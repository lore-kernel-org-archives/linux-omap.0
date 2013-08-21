From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] arm: omap5: hwmod: add missing ocp2scp hwmod data
Date: Wed, 21 Aug 2013 14:11:21 +0200
Message-ID: <5214AE69.8010009@baylibre.com>
References: <1373642066-5235-1-git-send-email-balbi@ti.com> <20130821074728.GV7656@atomide.com> <52148C67.3080106@baylibre.com> <CALpuT30YToRvgS3rgvpSZf8d1DZBK9y5mNUJL6qbHS22mL4k-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48205 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab3HUMLZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 08:11:25 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so633160wib.10
        for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 05:11:23 -0700 (PDT)
In-Reply-To: <CALpuT30YToRvgS3rgvpSZf8d1DZBK9y5mNUJL6qbHS22mL4k-g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

+ Kishon and Roger

Ok, so in fact that's a complete series now.

[v2,1/5] arm: omap5: dts: fix reg property size
[v2,2/5] arm: omap5: dts: fix ocp2scp DTS data
[v2,3/5] arm: omap5: dts: add palmas-usb node
[v2,4/5] arm: omap5: hwmod: add missing ocp2scp hwmod data
[v2,5/5] arm: omap2plus_defconfig: enable dwc3 and dependencies

Moreover, it does not build because of the change in the palmas SMPS10 =
regulator name from Kishon I already pulled.

Kishon or Roger,

Could you resend that series ASAP after fixing, testing and changing my=
 email address?


Tony,

I will need your ack for the omap2plus_defconfig patch.=20

Thanks,
Benoit=20


On 21/08/2013 11:48, Benoit Cousson wrote:
> Gosh, I've just realized it does contain some DTS stuff in it as well=
 :-(
> I should have pushed it in my DTS branch.
>=20
> Benoit
>=20
>=20
> 2013/8/21 Benoit Cousson <bcousson@baylibre.com=20
> <mailto:bcousson@baylibre.com>>
>=20
>     On 21/08/2013 09:47, Tony Lindgren wrote:
>=20
>         Benoit,
>=20
>         Got this one queued up somewhere?
>=20
>=20
>     No yet. That's the only hwmod patch I have so far.
>     I'll put it in a branch and send you the pull-request ASAP.
>=20
>     Regards,
>     Benoit
>=20
>=20
>=20
>         * Felipe Balbi <balbi@ti.com <mailto:balbi@ti.com>> [130712 0=
8:21]:
>=20
>             From: Benoit Cousson <benoit.cousson@linaro.org
>             <mailto:benoit.cousson@linaro.org>>
>=20
>             without that hwmod data, USB3 will not in OMAP5 boards.
>=20
>             While at that, also fix DTS data to pass reg property,
>             otherwise driver won't probe.
>=20
>             Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org
>             <mailto:benoit.cousson@linaro.org>>
>             Signed-off-by: Felipe Balbi <balbi@ti.com <mailto:balbi@t=
i.com>>
>             ---
>=20
>             tested on OMAP5 uEVM. Gets rid of a data abort when USB3
>             is enabled. There still some other patches missing to get
>             USB3 working out of the box, but that's on Palmas and wil=
l
>             come as soon as I get those ready.
>=20
>             This is already on step forward.
>=20
>                arch/arm/boot/dts/omap5.dtsi               |  3 +-
>                arch/arm/mach-omap2/omap___hwmod_54xx_data.c | 45
>             ++++++++++++++++++++++++++++++
>                2 files changed, 47 insertions(+), 1 deletion(-)
>=20
>             diff --git a/arch/arm/boot/dts/omap5.dtsi
>             b/arch/arm/boot/dts/omap5.dtsi
>             index da41d70..a0de586 100644
>             --- a/arch/arm/boot/dts/omap5.dtsi
>             +++ b/arch/arm/boot/dts/omap5.dtsi
>             @@ -654,10 +654,11 @@
>                                      };
>                              };
>=20
>             -               ocp2scp {
>             +               ocp2scp@4a080000 {
>                                      compatible =3D "ti,omap-ocp2scp"=
;
>                                      #address-cells =3D <1>;
>                                      #size-cells =3D <1>;
>             +                       reg =3D <0x4a080000 0x20>;
>                                      ranges;
>                                      ti,hwmods =3D "ocp2scp1";
>                                      usb2_phy: usb2phy@4a084000 {
>             diff --git a/arch/arm/mach-omap2/omap___hwmod_54xx_data.c
>             b/arch/arm/mach-omap2/omap___hwmod_54xx_data.c
>             index 2435109..d9118a1 100644
>             --- a/arch/arm/mach-omap2/omap___hwmod_54xx_data.c
>             +++ b/arch/arm/mach-omap2/omap___hwmod_54xx_data.c
>             @@ -1105,6 +1105,42 @@ static struct omap_hwmod
>             omap54xx_mpu_hwmod =3D {
>                };
>=20
>                /*
>             + * 'ocp2scp' class
>             + * bridge to transform ocp interface protocol to scp
>             (serial control port)
>             + * protocol
>             + */
>             +
>             +static struct omap_hwmod_class_sysconfig
>             omap54xx_ocp2scp_sysc =3D {
>             +       .rev_offs       =3D 0x0000,
>             +       .sysc_offs      =3D 0x0010,
>             +       .syss_offs      =3D 0x0014,
>             +       .sysc_flags     =3D (SYSC_HAS_AUTOIDLE |
>             SYSC_HAS_SIDLEMODE |
>             +                       SYSC_HAS_SOFTRESET |
>             SYSS_HAS_RESET_STATUS),
>             +       .idlemodes      =3D (SIDLE_FORCE | SIDLE_NO |
>             SIDLE_SMART),
>             +       .sysc_fields    =3D &omap_hwmod_sysc_type1,
>             +};
>             +
>             +static struct omap_hwmod_class omap54xx_ocp2scp_hwmod_cl=
ass =3D {
>             +       .name   =3D "ocp2scp",
>             +       .sysc   =3D &omap54xx_ocp2scp_sysc,
>             +};
>             +
>             +/* ocp2scp1 */
>             +static struct omap_hwmod omap54xx_ocp2scp1_hwmod =3D {
>             +       .name           =3D "ocp2scp1",
>             +       .class          =3D &omap54xx_ocp2scp_hwmod_class=
,
>             +       .clkdm_name     =3D "l3init_clkdm",
>             +       .main_clk       =3D "l4_root_clk_div",
>             +       .prcm =3D {
>             +               .omap4 =3D {
>             +                       .clkctrl_offs =3D
>             OMAP54XX_CM_L3INIT_OCP2SCP1___CLKCTRL_OFFSET,
>             +                       .context_offs =3D
>             OMAP54XX_RM_L3INIT_OCP2SCP1___CONTEXT_OFFSET,
>             +                       .modulemode   =3D MODULEMODE_HWCT=
RL,
>             +               },
>             +       },
>             +};
>             +
>             +/*
>                 * 'timer' class
>                 * general purpose timer module with accurate 1ms tick
>                 * This class contains several variants: ['timer_1ms',
>             'timer']
>             @@ -1900,6 +1936,14 @@ static struct omap_hwmod_ocp_if
>             omap54xx_l4_cfg__mpu =3D {
>                      .user           =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>                };
>=20
>             +/* l4_cfg -> ocp2scp1 */
>             +static struct omap_hwmod_ocp_if omap54xx_l4_cfg__ocp2scp=
1 =3D {
>             +       .master         =3D &omap54xx_l4_cfg_hwmod,
>             +       .slave          =3D &omap54xx_ocp2scp1_hwmod,
>             +       .clk            =3D "l4_root_clk_div",
>             +       .user           =3D OCP_USER_MPU | OCP_USER_SDMA,
>             +};
>             +
>                /* l4_wkup -> timer1 */
>                static struct omap_hwmod_ocp_if omap54xx_l4_wkup__time=
r1 =3D {
>                      .master         =3D &omap54xx_l4_wkup_hwmod,
>             @@ -2102,6 +2146,7 @@ static struct omap_hwmod_ocp_if
>             *omap54xx_hwmod_ocp_ifs[] __initdata =3D {
>                      &omap54xx_l4_per__mmc4,
>                      &omap54xx_l4_per__mmc5,
>                      &omap54xx_l4_cfg__mpu,
>             +       &omap54xx_l4_cfg__ocp2scp1,
>                      &omap54xx_l4_wkup__timer1,
>                      &omap54xx_l4_per__timer2,
>                      &omap54xx_l4_per__timer3,
>             --
>             1.8.2.1
>=20
>=20
>=20
>=20
>=20
> --=20
> *Beno=EEt Cousson*
> CTO
> BayLibre - Incubateur PACA Est
> Business Pole
> 1047 route des Dolines, Acc=E8s All=E9e Pierre Ziller, Entr=E9e A
> 06560 Valbonne Sophia Antipolis

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
