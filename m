From: "Kumar, Anil" <anilkumar.v-l0cyMroinI0@public.gmane.org>
Subject: Use of of_parse_phandle()/of_node_put()
Date: Wed, 13 Feb 2013 06:04:35 +0000
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412C6E52@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4667858887916314625=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Ujfalusi, Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Alsa Devel List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Girdwood,
 Liam" <lrg-l0cyMroinI0@public.gmane.org>, "jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org" <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--===============4667858887916314625==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_F3DBB1B3EF102E4994C89758CFCA32412C6E52DBDE01entticom_"

--_000_F3DBB1B3EF102E4994C89758CFCA32412C6E52DBDE01entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi  Peter,

Just trying to understand.

In omap-twl4030.c file probe function :-

 dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
                if (!dai_node) {
                        dev_err(&pdev->dev, "McBSP node is not provided\n")=
;
                        return -EINVAL;
                }

Here  "of_parse_phandle()"  is used to get  "of_device" node pointer.
of_parse_phandle() suggest to use of_node_put()  on it when done.

It looks when code request for an "of_device" node, kernel  maintains "refc=
ount" for this.
It check "refcount"  before giving pointer of of_device node and  WARN_ON()
in case of refcount  > 0 and increase it on success.

Should this code need to use of_node_put() on the requested "of_device" whe=
n done
so that this can be get  again ?

I am taking reference of Linux-next kernel.

I'm sorry if this question is very vague or  missing something.

Thanks,
Anil







--_000_F3DBB1B3EF102E4994C89758CFCA32412C6E52DBDE01entticom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<div>Hi&nbsp; Peter,</div>
<div>&nbsp;</div>
<div>Just trying to understand.</div>
<div>&nbsp;</div>
<div>In omap-twl4030.c file probe function :-</div>
<div>&nbsp;</div>
<div> dai_node =3D of_parse_phandle(node, &quot;ti,mcbsp&quot;, 0);</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!dai_node) {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_er=
r(&amp;pdev-&gt;dev, &quot;McBSP node is not provided\n&quot;);</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 -EINVAL;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }</div>
<div>&nbsp;</div>
<div>Here&nbsp; &#8220;of_parse_phandle()&#8221;&nbsp; is used to get&nbsp;=
 &#8220;of_device&#8221; node pointer.</div>
<div>of_parse_phandle() suggest to use of_node_put()&nbsp; on it when done.=
</div>
<div>&nbsp;</div>
<div>It looks when code request for an &#8220;of_device&#8221; node, kernel=
&nbsp; maintains &#8220;refcount&#8221; for this.</div>
<div>It check &#8220;refcount&#8221;&nbsp; before giving pointer of of_devi=
ce node and&nbsp; WARN_ON()</div>
<div>in case of refcount&nbsp; &gt; 0 and increase it on success. </div>
<div>&nbsp;</div>
<div>Should this code need to use of_node_put() on the requested &#8220;of_=
device&#8221; when done</div>
<div>so that this can be get&nbsp; again ?</div>
<div>&nbsp;</div>
<div>I am taking reference of Linux-next kernel.</div>
<div>&nbsp;</div>
<div>I'm sorry if this question is very vague or&nbsp; missing something.</=
div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Anil</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</span></font>
</body>
</html>

--_000_F3DBB1B3EF102E4994C89758CFCA32412C6E52DBDE01entticom_--

--===============4667858887916314625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4667858887916314625==--
