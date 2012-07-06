From: Xiao Jiang <jgq516@gmail.com>
Subject: Re: [PATCH 1/1] ARM: add PROC_DEVICETREE support in Kconfig
Date: Sat, 7 Jul 2012 07:15:38 +0800
Message-ID: <CAERv70uZMEoX4OcECssOrktVzC911tiSLXRH56TjyhQqVgNwBA@mail.gmail.com>
References: <1341571127-14461-1-git-send-email-jgq516@gmail.com>
 <4FF6DCCA.2080509@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5171215159057673942=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FF6DCCA.2080509@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux@arm.linux.org.uk, arnd@arndb.de, tony@atomide.com, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, olof@lixom.net, swarren@nvidia.com, linux-omap@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, hdoyu@nvidia.com
List-Id: linux-omap@vger.kernel.org

--===============5171215159057673942==
Content-Type: multipart/alternative; boundary=14dae93408ab310bc204c4317146

--14dae93408ab310bc204c4317146
Content-Type: text/plain; charset=ISO-8859-1

2012/7/6 Rob Herring <robherring2@gmail.com>

> On 07/06/2012 05:38 AM, jgq516@gmail.com wrote:
> > From: Xiao Jiang <jgq516@gmail.com>
> >
> > Since more and more arm chips support device tree, it'd be better add
> PROC_DEVICETREE
> > in arch/arm/Kconfig to avoid duplicate code.
>
> I think this should remain user choice. If its going to be selected,
> then you might as well just remove the option altogether. Perhaps just
> make the option default to yes.
>
> Hmm, sounds reasonable from your point. So the better choice is to set the
option default to Y if the board has dt support just like tegra_defconfig
and at91_dt_defconfig,  right? thanks.

Regards,
Xiao

Rob
>
> > Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> > ---
> >  arch/arm/Kconfig                   |    1 +
> >  arch/arm/configs/at91_dt_defconfig |    1 -
> >  arch/arm/configs/tegra_defconfig   |    1 -
> >  arch/arm/plat-omap/Kconfig         |    1 -
> >  4 files changed, 1 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a91009c..f68896e 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1864,6 +1864,7 @@ config USE_OF
> >       select OF
> >       select OF_EARLY_FLATTREE
> >       select IRQ_DOMAIN
> > +     select PROC_DEVICETREE if PROC_FS
> >       help
> >         Include support for flattened device tree machine descriptions.
> >
> > diff --git a/arch/arm/configs/at91_dt_defconfig
> b/arch/arm/configs/at91_dt_defconfig
> > index 67bc571..b856cb6 100644
> > --- a/arch/arm/configs/at91_dt_defconfig
> > +++ b/arch/arm/configs/at91_dt_defconfig
> > @@ -64,7 +64,6 @@ CONFIG_MTD_NAND=y
> >  CONFIG_MTD_NAND_ATMEL=y
> >  CONFIG_MTD_UBI=y
> >  CONFIG_MTD_UBI_GLUEBI=y
> > -CONFIG_PROC_DEVICETREE=y
> >  CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_BLK_DEV_RAM=y
> >  CONFIG_BLK_DEV_RAM_COUNT=4
> > diff --git a/arch/arm/configs/tegra_defconfig
> b/arch/arm/configs/tegra_defconfig
> > index 1198dd6..43e7b65 100644
> > --- a/arch/arm/configs/tegra_defconfig
> > +++ b/arch/arm/configs/tegra_defconfig
> > @@ -72,7 +72,6 @@ CONFIG_IPV6_TUNNEL=y
> >  CONFIG_IPV6_MULTIPLE_TABLES=y
> >  # CONFIG_WIRELESS is not set
> >  # CONFIG_FIRMWARE_IN_KERNEL is not set
> > -CONFIG_PROC_DEVICETREE=y
> >  CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_AD525X_DPOT=y
> >  CONFIG_AD525X_DPOT_I2C=y
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index ad95c7a..4e2cb17 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -27,7 +27,6 @@ config ARCH_OMAP2PLUS
> >       select GENERIC_IRQ_CHIP
> >       select OMAP_DM_TIMER
> >       select USE_OF
> > -     select PROC_DEVICETREE if PROC_FS
> >       help
> >         "Systems based on OMAP2, OMAP3 or OMAP4"
> >
> >
>
>
>

--14dae93408ab310bc204c4317146
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/7/6 Rob Herring <span dir=3D"ltr">&lt;<a href=3D"mailto:robherring2@gm=
ail.com" target=3D"_blank">robherring2@gmail.com</a>&gt;</span><br><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0p=
t 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im">On 07/06/2012 05:38 AM, <a href=3D"mailto:jgq516@gmail.co=
m">jgq516@gmail.com</a> wrote:<br>
&gt; From: Xiao Jiang &lt;<a href=3D"mailto:jgq516@gmail.com">jgq516@gmail.=
com</a>&gt;<br>
&gt;<br>
&gt; Since more and more arm chips support device tree, it&#39;d be better =
add PROC_DEVICETREE<br>
&gt; in arch/arm/Kconfig to avoid duplicate code.<br>
<br>
</div>I think this should remain user choice. If its going to be selected,<=
br>
then you might as well just remove the option altogether. Perhaps just<br>
make the option default to yes.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div>Hmm, sounds reasonable from your point. So the better choice is to =
set the option default to Y if the board has dt support just like tegra_def=
config and at91_dt_defconfig,=A0 right? thanks.<br>
<br>Regards,<br>Xiao<br><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888">
Rob<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Signed-off-by: Xiao Jiang &lt;<a href=3D"mailto:jgq516@gmail.com">jgq5=
16@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +<b=
r>
&gt; =A0arch/arm/configs/at91_dt_defconfig | =A0 =A01 -<br>
&gt; =A0arch/arm/configs/tegra_defconfig =A0 | =A0 =A01 -<br>
&gt; =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 | =A0 =A01 -<br>
&gt; =A04 files changed, 1 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig<br>
&gt; index a91009c..f68896e 100644<br>
&gt; --- a/arch/arm/Kconfig<br>
&gt; +++ b/arch/arm/Kconfig<br>
&gt; @@ -1864,6 +1864,7 @@ config USE_OF<br>
&gt; =A0 =A0 =A0 select OF<br>
&gt; =A0 =A0 =A0 select OF_EARLY_FLATTREE<br>
&gt; =A0 =A0 =A0 select IRQ_DOMAIN<br>
&gt; + =A0 =A0 select PROC_DEVICETREE if PROC_FS<br>
&gt; =A0 =A0 =A0 help<br>
&gt; =A0 =A0 =A0 =A0 Include support for flattened device tree machine desc=
riptions.<br>
&gt;<br>
&gt; diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at9=
1_dt_defconfig<br>
&gt; index 67bc571..b856cb6 100644<br>
&gt; --- a/arch/arm/configs/at91_dt_defconfig<br>
&gt; +++ b/arch/arm/configs/at91_dt_defconfig<br>
&gt; @@ -64,7 +64,6 @@ CONFIG_MTD_NAND=3Dy<br>
&gt; =A0CONFIG_MTD_NAND_ATMEL=3Dy<br>
&gt; =A0CONFIG_MTD_UBI=3Dy<br>
&gt; =A0CONFIG_MTD_UBI_GLUEBI=3Dy<br>
&gt; -CONFIG_PROC_DEVICETREE=3Dy<br>
&gt; =A0CONFIG_BLK_DEV_LOOP=3Dy<br>
&gt; =A0CONFIG_BLK_DEV_RAM=3Dy<br>
&gt; =A0CONFIG_BLK_DEV_RAM_COUNT=3D4<br>
&gt; diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra=
_defconfig<br>
&gt; index 1198dd6..43e7b65 100644<br>
&gt; --- a/arch/arm/configs/tegra_defconfig<br>
&gt; +++ b/arch/arm/configs/tegra_defconfig<br>
&gt; @@ -72,7 +72,6 @@ CONFIG_IPV6_TUNNEL=3Dy<br>
&gt; =A0CONFIG_IPV6_MULTIPLE_TABLES=3Dy<br>
&gt; =A0# CONFIG_WIRELESS is not set<br>
&gt; =A0# CONFIG_FIRMWARE_IN_KERNEL is not set<br>
&gt; -CONFIG_PROC_DEVICETREE=3Dy<br>
&gt; =A0CONFIG_BLK_DEV_LOOP=3Dy<br>
&gt; =A0CONFIG_AD525X_DPOT=3Dy<br>
&gt; =A0CONFIG_AD525X_DPOT_I2C=3Dy<br>
&gt; diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig<b=
r>
&gt; index ad95c7a..4e2cb17 100644<br>
&gt; --- a/arch/arm/plat-omap/Kconfig<br>
&gt; +++ b/arch/arm/plat-omap/Kconfig<br>
&gt; @@ -27,7 +27,6 @@ config ARCH_OMAP2PLUS<br>
&gt; =A0 =A0 =A0 select GENERIC_IRQ_CHIP<br>
&gt; =A0 =A0 =A0 select OMAP_DM_TIMER<br>
&gt; =A0 =A0 =A0 select USE_OF<br>
&gt; - =A0 =A0 select PROC_DEVICETREE if PROC_FS<br>
&gt; =A0 =A0 =A0 help<br>
&gt; =A0 =A0 =A0 =A0 &quot;Systems based on OMAP2, OMAP3 or OMAP4&quot;<br>
&gt;<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br>

--14dae93408ab310bc204c4317146--


--===============5171215159057673942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5171215159057673942==--
