<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="diffspec.xsl"/>
  </p:input>
</p:xslt>

</p:declare-step>
