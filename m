From: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH 06/12] mtd: nand: gpmi: rely on generic DT
 parsing done in nand_scan_ident()
Date: Sat, 16 Apr 2016 18:46:49 +0000
Message-ID: <DB5PR0401MB1845316E7C7118FE166A190B97690@DB5PR0401MB1845.eurprd04.prod.outlook.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459515272-31011-7-git-send-email-boris.brezillon@free-electrons.com>,<20160416110720.462822e6@bbrezillon>
Reply-To: han.xu-3arQi8VN3Tc@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_000_DB5PR0401MB1845316E7C7118FE166A190B97690DB5PR0401MB1845_"
Return-path: <linux-sunxi+bncBCBMF4HBYUEBBG4RZK4AKGQEQ25N7EQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160416110720.462822e6@bbrezillon>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wenyou
 Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Richard
 Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--_000_DB5PR0401MB1845316E7C7118FE166A190B97690DB5PR0401MB1845_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable




________________________________
From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sent: Saturday, April 16, 2016 3:07 AM
To: Han Xu
Cc: Roger Quadros; Tony Lindgren; Wenyou Yang; Josh Wu; Boris Brezillon; Ri=
chard Weinberger; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; David Woodhouse; Brian Nor=
ris; Kamal Dasu; Ezequiel Garcia; Stefan Agner; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=
 Nicolas Ferre; Jean-Christophe Plagniol-Villard; Alexandre Belloni; Thomas=
 Petazzoni; Gregory CLEMENT; Jason Cooper; Sebastian Hesselbarth; Andrew Lu=
nn; Daniel Mack; Haojian Zhuang; Robert Jarzmik; bcm-kernel-feedback-list@b=
roadcom.com; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
.org; Maxime Ripard; Chen-Yu Tsai; linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Zhou Wang;=
 Alex Smith; Harvey Hunt
Subject: Re: [PATCH 06/12] mtd: nand: gpmi: rely on generic DT parsing done=
 in nand_scan_ident()

Hi Han,

On Fri,  1 Apr 2016 14:54:26 +0200
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.

Can you review/test this patch? I'd like to have the whole series
merged in this release.

Thanks,

Boris

>
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gp=
mi-nand/gpmi-nand.c
> index 8122c69..c6e8a1c 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -25,7 +25,6 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_mtd.h>
>  #include "gpmi-nand.h"
>  #include "bch-regs.h"
>
> @@ -1914,16 +1913,6 @@ static int gpmi_nand_init(struct gpmi_nand_data *t=
his)
>        /* Set up swap_block_mark, must be set before the gpmi_set_geometr=
y() */
>        this->swap_block_mark =3D !GPMI_IS_MX23(this);
>
> -     if (of_get_nand_on_flash_bbt(this->dev->of_node)) {
> -             chip->bbt_options |=3D NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB=
;
> -
> -             if (of_property_read_bool(this->dev->of_node,
> -                                             "fsl,no-blockmark-swap"))
> -                     this->swap_block_mark =3D false;
> -     }
> -     dev_dbg(this->dev, "Blockmark swapping %sabled\n",
> -             this->swap_block_mark ? "en" : "dis");
> -
>        /*
>         * Allocate a temporary DMA buffer for reading ID in the
>         * nand_scan_ident().
> @@ -1938,6 +1927,16 @@ static int gpmi_nand_init(struct gpmi_nand_data *t=
his)
>        if (ret)
>                goto err_out;
>
> +     if (chip->bbt_options & NAND_BBT_USE_FLASH) {
> +             chip->bbt_options |=3D NAND_BBT_NO_OOB;
> +
> +             if (of_property_read_bool(this->dev->of_node,
> +                                             "fsl,no-blockmark-swap"))
> +                     this->swap_block_mark =3D false;
> +     }
> +     dev_dbg(this->dev, "Blockmark swapping %sabled\n",
> +             this->swap_block_mark ? "en" : "dis");
> +

Sorry for late, it's fine for me.
Acked-by: Han xu <han.xu-3arQi8VN3Tc@public.gmane.org>

>        ret =3D gpmi_init_last(this);
>        if (ret)
>                goto err_out;



--
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
[http://free-electrons.com/wp-content/header-images/buildroot-course-940x19=
8.jpg]<http://free-electrons.com/>

Embedded Linux Experts - Free Electrons<http://free-electrons.com/>
free-electrons.com
Free Electrons is an engineering company specialized in embedded Linux and =
more generally in Free and Open Source software for embedded systems.



--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--_000_DB5PR0401MB1845316E7C7118FE166A190B97690DB5PR0401MB1845_
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri, sans-serif" style=3D"font-size:11pt"><b>From:</b> Boris Brezillon &lt=
;boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, April 16, 2016 3:07 AM<br>
<b>To:</b> Han Xu<br>
<b>Cc:</b> Roger Quadros; Tony Lindgren; Wenyou Yang; Josh Wu; Boris Brezil=
lon; Richard Weinberger; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; David Woodhouse; Br=
ian Norris; Kamal Dasu; Ezequiel Garcia; Stefan Agner; linux-omap-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org; Nicolas Ferre; Jean-Christophe
 Plagniol-Villard; Alexandre Belloni; Thomas Petazzoni; Gregory CLEMENT; Ja=
son Cooper; Sebastian Hesselbarth; Andrew Lunn; Daniel Mack; Haojian Zhuang=
; Robert Jarzmik; bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; linux-arm-kernel@l=
ists.infradead.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
 Maxime Ripard; Chen-Yu Tsai; linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Zhou Wang; Alex=
 Smith; Harvey Hunt<br>
<b>Subject:</b> Re: [PATCH 06/12] mtd: nand: gpmi: rely on generic DT parsi=
ng done in nand_scan_ident()</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Han,<br>
<br>
On Fri,&nbsp; 1 Apr 2016 14:54:26 &#43;0200<br>
Boris Brezillon &lt;boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org&gt; wrote:<br>
<br>
&gt; The core now takes care of parsing generic DT properties in<br>
&gt; nand_scan_ident() when nand_set_flash_node() has been called.<br>
&gt; Rely on this initialization instead of calling of_get_nand_xxx()<br>
&gt; manually.<br>
<br>
Can you review/test this patch? I'd like to have the whole series<br>
merged in this release.<br>
<br>
Thanks,<br>
<br>
Boris<br>
<br>
&gt; <br>
&gt; Signed-off-by: Boris Brezillon &lt;boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org&=
gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 21 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;-----------<br>
&gt;&nbsp; 1 file changed, 10 insertions(&#43;), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand=
/gpmi-nand/gpmi-nand.c<br>
&gt; index 8122c69..c6e8a1c 100644<br>
&gt; --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c<br>
&gt; &#43;&#43;&#43; b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c<br>
&gt; @@ -25,7 &#43;25,6 @@<br>
&gt;&nbsp; #include &lt;linux/mtd/partitions.h&gt;<br>
&gt;&nbsp; #include &lt;linux/of.h&gt;<br>
&gt;&nbsp; #include &lt;linux/of_device.h&gt;<br>
&gt; -#include &lt;linux/of_mtd.h&gt;<br>
&gt;&nbsp; #include &quot;gpmi-nand.h&quot;<br>
&gt;&nbsp; #include &quot;bch-regs.h&quot;<br>
&gt;&nbsp; <br>
&gt; @@ -1914,16 &#43;1913,6 @@ static int gpmi_nand_init(struct gpmi_nand_=
data *this)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set up swap_block_mark, m=
ust be set before the gpmi_set_geometry() */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this-&gt;swap_block_mark =3D=
 !GPMI_IS_MX23(this);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (of_get_nand_on_flash_bbt(this-&gt;dev-&g=
t;of_node)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; chip-&gt;bbt_options |=3D NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (of_property_read_bool(this-&gt;dev-&gt;of_node,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;fsl,no-blockmark-swap&q=
uot;))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this-&gt;swap_block_mar=
k =3D false;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(this-&gt;dev, &quot;Blockmark swappi=
ng %sabled\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; this-&gt;swap_block_mark ? &quot;en&quot; : &quot;dis&quot;);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Allocate a temporary=
 DMA buffer for reading ID in the<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * nand_scan_ident().<b=
r>
&gt; @@ -1938,6 &#43;1927,16 @@ static int gpmi_nand_init(struct gpmi_nand_=
data *this)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err_out;<br>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (chip-&gt;bbt_options &amp; NAND_BBT_=
USE_FLASH) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; chip-&gt;bbt_options |=3D NAND_BBT_NO_OOB;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (of_property_read_bool(this-&gt;dev-&gt;of_node,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;fsl,no-blockmark-sw=
ap&quot;))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this-&gt;swap_block=
_mark =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(this-&gt;dev, &quot;Blockmark sw=
apping %sabled\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; this-&gt;swap_block_mark ? &quot;en&quot; : &quot;dis&quot;);<br>
&gt; &#43;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Sorry for late, it's fine for me.</div>
<div class=3D"PlainText">Acked-by: Han xu &lt;<a>han.xu-3arQi8VN3Tc@public.gmane.org</a>&gt;</di=
v>
<div class=3D"PlainText"><br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D gpmi_init_last(this)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err_out;<br>
<br>
<br>
<br>
-- <br>
Boris Brezillon, Free Electrons<br>
Embedded Linux and Kernel engineering<br>
<a id=3D"LPlnk21663" href=3D"http://free-electrons.com">http://free-electro=
ns.com</a></div>
<div class=3D"PlainText">
<div id=3D"LPBorder_GT_14608323264580.10828512502052445" style=3D"width: 10=
0%; text-indent: 0px; overflow: auto; margin-bottom: 20px;">
<table id=3D"LPContainer_14608323264520.2608825572642813" style=3D"width: 9=
0%; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 20=
px; border-top-color: rgb(200, 200, 200); border-bottom-color: rgb(200, 200=
, 200); border-top-width: 1px; border-bottom-width: 1px; border-top-style: =
dotted; border-bottom-style: dotted; position: relative; background-color: =
rgb(255, 255, 255);" cellspacing=3D"0">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"ImageCell_14608323264530.3936292221089715" style=3D"width: 250px;=
 padding-right: 20px; display: table-cell; position: relative;" colspan=3D"=
1">
<div id=3D"LPImageContainer_14608323264530.1365048229797905" style=3D"margi=
n: auto; width: 250px; height: 52px; display: table; position: relative; ba=
ckground-color: rgb(255, 255, 255);">
<a id=3D"LPImageAnchor_14608323264540.6753602874967639" style=3D"text-align=
: center; display: table-cell;" href=3D"http://free-electrons.com/" target=
=3D"_blank"><img width=3D"250" height=3D"52" style=3D"border-width: 0px; wi=
dth: 250px; height: 52px; margin-right: auto; margin-left: auto; vertical-a=
lign: bottom; display: inline-block; max-height: 250px; max-width: 250px;" =
aria-label=3D"Preview image with link selected. Double-tap to open the link=
." src=3D"http://free-electrons.com/wp-content/header-images/buildroot-cour=
se-940x198.jpg"></a></div>
</td>
<td id=3D"TextCell_14608323264550.9787652687016757" style=3D"padding: 0px; =
vertical-align: top; display: table-cell; position: relative;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_14608323264550.5646849574489943"></div>
<div id=3D"LPTitle_14608323264550.49626829918246134" style=3D"top: 0px; col=
or: rgb(0, 120, 215); line-height: 21px; font-family: &quot;wf_segoe-ui_lig=
ht&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quot;Segoe =
UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 21px; fon=
t-weight: 400;">
<a id=3D"LPUrlAnchor_14608323264560.9805770609234055" style=3D"text-decorat=
ion: none;" href=3D"http://free-electrons.com/" target=3D"_blank">Embedded =
Linux Experts - Free Electrons</a></div>
<div id=3D"LPMetadata_14608323264560.7594492830221395" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); line-height: 14px; font-family: &quo=
t;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma=
,Arial,sans-serif; font-size: 14px; font-weight: 400;">
free-electrons.com</div>
<div id=3D"LPDescription_14608323264570.520230912316602" style=3D"color: rg=
b(102, 102, 102); line-height: 20px; overflow: hidden; font-family: &quot;w=
f_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Ar=
ial,sans-serif; font-size: 14px; font-weight: 400; display: block; max-heig=
ht: 100px;">
Free Electrons is an engineering company specialized in embedded Linux and =
more generally in Free and Open Source software for embedded systems.</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class=3D"PlainText"><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--_000_DB5PR0401MB1845316E7C7118FE166A190B97690DB5PR0401MB1845_--
