From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH 1/5] ARM: OMAP3EVM: Add NAND flash definition
Date: Tue, 12 Jun 2012 10:22:50 +0800
Message-ID: <CA+Y31wfZbtr0L84QLDzdA83yhLTCDUcS5L_bS4zV0upGYFG9zw@mail.gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-2-git-send-email-zumeng.chen@gmail.com>
 <4FD6073F.8080703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7601621624084243757=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FD6073F.8080703@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: khilman@ti.com, zumeng chen <zumeng.chen@gmail.com>, tony@atomide.com, hvaibhav@ti.com, ajay.gupta@ti.com, khasim@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7601621624084243757==
Content-Type: multipart/alternative; boundary=14dae9340c3ba5bfa004c23d249d

--14dae9340c3ba5bfa004c23d249d
Content-Type: text/plain; charset=ISO-8859-1

Hi Jon,

Many thanks for your quickly reply, please see my in-line reply

2012/6/11 Jon Hunter <jon-hunter@ti.com>

>
>
> On 06/11/2012 09:00 AM, Zumeng Chen wrote:
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Tested-by: Zumeng Chen <zumeng.chen@gmail.com>
>
> I think that you need to have something in the changelog above, even if
> this is a trivial change.
>
Yes, I'll add it in V2

>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |   39
> ++++++++++++++++++++++++++++++++++
> >  1 files changed, 39 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-omap2/board-omap3evm.c
> > index 639bd07..fef911d 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -24,6 +24,10 @@
> >  #include <linux/leds.h>
> >  #include <linux/interrupt.h>
> >
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/partitions.h>
> > +#include <linux/mtd/nand.h>
> > +
> >  #include <linux/spi/spi.h>
> >  #include <linux/spi/ads7846.h>
> >  #include <linux/i2c/twl.h>
> > @@ -43,6 +47,7 @@
> >
> >  #include <plat/board.h>
> >  #include <plat/usb.h>
> > +#include <plat/nand.h>
> >  #include "common.h"
> >  #include <plat/mcspi.h>
> >  #include <video/omapdss.h>
> > @@ -607,6 +612,37 @@ static struct regulator_consumer_supply
> dummy_supplies[] = {
> >       REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
> >  };
> >
> > +static struct mtd_partition omap3evm_nand_partitions[] = {
> > +     /* All the partition sizes are listed in terms of NAND block size
> */
> > +     {
> > +             .name           = "xloader-nand",
>
> Is this the only non-volatile memory on the EVM? If so, you can probably
> drop the "-nand" part from the name. Also, if you look at other board
> files to be consistent in naming they use "X-Loader".
>
As this kind usage, yes, the only memory. so I'll remove "nand" for all.

>
> > +             .offset         = 0,
> > +             .size           = 4*(SZ_128K),
> > +             .mask_flags     = MTD_WRITEABLE
> > +     },
> > +     {
> > +             .name           = "uboot-nand",
>
> "U-Boot"
>
> > +             .offset         = MTDPART_OFS_APPEND,
> > +             .size           = 14*(SZ_128K),
> > +             .mask_flags     = MTD_WRITEABLE
> > +     },
> > +     {
> > +             .name           = "params-nand",
>
> "U-Boot Env"
>
> > +             .offset         = MTDPART_OFS_APPEND,
> > +             .size           = 2*(SZ_128K)
> > +     },
> > +     {
> > +             .name           = "linux-nand",
>
> "Kernel"
>
> > +             .offset         = MTDPART_OFS_APPEND,
> > +             .size           = 40*(SZ_128K)
> > +     },
> > +     {
> > +             .name           = "jffs2-nand",
>
> "File System"
> > +             .size           = MTDPART_SIZ_FULL,
> > +             .offset         = MTDPART_OFS_APPEND,
> > +     },
> > +};
> > +
> >  static void __init omap3_evm_init(void)
> >  {
> >       struct omap_board_mux *obm;
> > @@ -656,6 +692,9 @@ static void __init omap3_evm_init(void)
> >       }
> >       usb_musb_init(&musb_board_data);
> >       usbhs_init(&usbhs_bdata);
> > +     omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
> > +                          ARRAY_SIZE(omap3evm_nand_partitions));
> > +
> >       omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
> >       omap3evm_init_smsc911x();
> >       omap3_evm_display_init();
>
All fixed in V2.

Regards,
Zumeng

>
> Cheers
> Jon
>

--14dae9340c3ba5bfa004c23d249d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jon,<br><br>Many thanks for your quickly reply, please see my in-line re=
ply<br><br><div class=3D"gmail_quote">2012/6/11 Jon Hunter <span dir=3D"ltr=
">&lt;<a href=3D"mailto:jon-hunter@ti.com" target=3D"_blank">jon-hunter@ti.=
com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"im"><br>
<br>
On 06/11/2012 09:00 AM, Zumeng Chen wrote:<br>
&gt; Signed-off-by: Vaibhav Hiremath &lt;<a href=3D"mailto:hvaibhav@ti.com"=
>hvaibhav@ti.com</a>&gt;<br>
&gt; Tested-by: Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@gmail.com">zu=
meng.chen@gmail.com</a>&gt;<br>
<br>
</div>I think that you need to have something in the changelog above, even =
if<br>
this is a trivial change.<br></blockquote><div>Yes, I&#39;ll add it in V2 <=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 39 +++++++++++++++++++++=
+++++++++++++<br>
&gt; =A01 files changed, 39 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap=
2/board-omap3evm.c<br>
&gt; index 639bd07..fef911d 100644<br>
&gt; --- a/arch/arm/mach-omap2/board-omap3evm.c<br>
&gt; +++ b/arch/arm/mach-omap2/board-omap3evm.c<br>
&gt; @@ -24,6 +24,10 @@<br>
&gt; =A0#include &lt;linux/leds.h&gt;<br>
&gt; =A0#include &lt;linux/interrupt.h&gt;<br>
&gt;<br>
&gt; +#include &lt;linux/mtd/mtd.h&gt;<br>
&gt; +#include &lt;linux/mtd/partitions.h&gt;<br>
&gt; +#include &lt;linux/mtd/nand.h&gt;<br>
&gt; +<br>
&gt; =A0#include &lt;linux/spi/spi.h&gt;<br>
&gt; =A0#include &lt;linux/spi/ads7846.h&gt;<br>
&gt; =A0#include &lt;linux/i2c/twl.h&gt;<br>
&gt; @@ -43,6 +47,7 @@<br>
&gt;<br>
&gt; =A0#include &lt;plat/board.h&gt;<br>
&gt; =A0#include &lt;plat/usb.h&gt;<br>
&gt; +#include &lt;plat/nand.h&gt;<br>
&gt; =A0#include &quot;common.h&quot;<br>
&gt; =A0#include &lt;plat/mcspi.h&gt;<br>
&gt; =A0#include &lt;video/omapdss.h&gt;<br>
&gt; @@ -607,6 +612,37 @@ static struct regulator_consumer_supply dummy_sup=
plies[] =3D {<br>
&gt; =A0 =A0 =A0 REGULATOR_SUPPLY(&quot;vdd33a&quot;, &quot;smsc911x.0&quot=
;),<br>
&gt; =A0};<br>
&gt;<br>
&gt; +static struct mtd_partition omap3evm_nand_partitions[] =3D {<br>
&gt; + =A0 =A0 /* All the partition sizes are listed in terms of NAND block=
 size */<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;xloader-=
nand&quot;,<br>
<br>
</div></div>Is this the only non-volatile memory on the EVM? If so, you can=
 probably<br>
drop the &quot;-nand&quot; part from the name. Also, if you look at other b=
oard<br>
files to be consistent in naming they use &quot;X-Loader&quot;.<br></blockq=
uote><div>As this kind usage, yes, the only memory. so I&#39;ll remove &quo=
t;nand&quot; for all. <br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4*(SZ_128K),<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;uboot-na=
nd&quot;,<br>
<br>
</div>&quot;U-Boot&quot;<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 14*(SZ_128K),<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;params-n=
and&quot;,<br>
<br>
</div>&quot;U-Boot Env&quot;<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 2*(SZ_128K)<br=
>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;linux-na=
nd&quot;,<br>
<br>
</div>&quot;Kernel&quot;<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 40*(SZ_128K)<b=
r>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;jffs2-na=
nd&quot;,<br>
<br>
</div>&quot;File System&quot;<br>
<div class=3D"im">&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =
=3D MTDPART_SIZ_FULL,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND,<br>
&gt; + =A0 =A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; =A0static void __init omap3_evm_init(void)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct omap_board_mux *obm;<br>
&gt; @@ -656,6 +692,9 @@ static void __init omap3_evm_init(void)<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 usb_musb_init(&amp;musb_board_data);<br>
&gt; =A0 =A0 =A0 usbhs_init(&amp;usbhs_bdata);<br>
&gt; + =A0 =A0 omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partiti=
ons,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap3e=
vm_nand_partitions));<br>
&gt; +<br>
&gt; =A0 =A0 =A0 omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);<br>
&gt; =A0 =A0 =A0 omap3evm_init_smsc911x();<br>
&gt; =A0 =A0 =A0 omap3_evm_display_init();<br></div></blockquote><div>All f=
ixed in V2.<br><br>Regards,<br>Zumeng <br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<div class=3D"im">
<br>
</div>Cheers<br>
<span class=3D"HOEnZb"><font color=3D"#888888">Jon<br>
</font></span></blockquote></div><br>

--14dae9340c3ba5bfa004c23d249d--


--===============7601621624084243757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7601621624084243757==--
