From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 2/2 v2] OMAP2/3: hwmod: fix gpio-reset timeouts seen
 during bootup.
Date: Wed, 6 Apr 2011 11:28:00 +0530
Message-ID: <BANLkTikwyk6b+d-QAz5LxuU_Lxgo4-A-hg@mail.gmail.com>
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
	<1302018015-8858-3-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33715 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795Ab1DFF6D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Apr 2011 01:58:03 -0400
Received: by mail-bw0-f47.google.com with SMTP id 5so1306778bwz.34
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 22:58:01 -0700 (PDT)
In-Reply-To: <1302018015-8858-3-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi,

On Tue, Apr 5, 2011 at 9:10 PM, Avinash.H.M <avinashhm@ti.com> wrote:
> GPIO module expects the debounce clocks to be enabled during reset. I=
t doesn't
> reset properly and timeouts are seen, if this clock isn't enabled dur=
ing
> reset. Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flags to the GPIO HWMO=
Ds, with
> which the debounce clocks are enabled during reset.
Minor comment,
Rephrase as " GPIO module doesn't reset properly and timeouts are seen
during bootup, if
debounce clock is not enabled"
to make commit log more clear.
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0 =A04 ++++
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 =A05 +++++
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 =A06 ++++++
> =A03 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_2420_data.c
> index 82ff5f7..e0bda0a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -1640,6 +1640,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio1=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2420_gpio1_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio1",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap242x_gpio1_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap242x_gpio1_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> @@ -1670,6 +1671,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio2=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2420_gpio2_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio2",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap242x_gpio2_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap242x_gpio2_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> @@ -1700,6 +1702,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio3=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2420_gpio3_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio3",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap242x_gpio3_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap242x_gpio3_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> @@ -1730,6 +1733,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio4=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2420_gpio4_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio4",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap242x_gpio4_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap242x_gpio4_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_2430_data.c
> index ce292f0..99cd7bd 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1743,6 +1743,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio1=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2430_gpio1_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio1",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap243x_gpio1_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap243x_gpio1_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> @@ -1773,6 +1774,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio2=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2430_gpio2_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio2",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap243x_gpio2_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap243x_gpio2_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> @@ -1803,6 +1805,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio3=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2430_gpio3_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio3",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap243x_gpio3_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap243x_gpio3_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> @@ -1833,6 +1836,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio4=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2430_gpio4_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio4",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap243x_gpio4_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap243x_gpio4_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpios_fck",
> @@ -1863,6 +1867,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio5=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap2430_gpio5_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio5",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap243x_gpio5_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap243x_gpio5_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpio5_fck",
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_3xxx_data.c
> index c74f972..7552b2f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -2142,6 +2142,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio1=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap3xxx_gpio1_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio1",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap3xxx_gpio1_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap3xxx_gpio1_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpio1_ick",
> @@ -2178,6 +2179,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio2=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap3xxx_gpio2_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio2",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap3xxx_gpio2_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap3xxx_gpio2_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpio2_ick",
> @@ -2214,6 +2216,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio3=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap3xxx_gpio3_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio3",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap3xxx_gpio3_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap3xxx_gpio3_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpio3_ick",
> @@ -2250,6 +2253,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio4=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap3xxx_gpio4_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio4",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap3xxx_gpio4_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap3xxx_gpio4_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpio4_ick",
> @@ -2286,6 +2290,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio5=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap3xxx_gpio5_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio5",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap3xxx_gpio5_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap3xxx_gpio5_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpio5_ick",
> @@ -2322,6 +2327,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio6=
_slaves[] =3D {
>
> =A0static struct omap_hwmod omap3xxx_gpio6_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio6",
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_CONTROL_OPT_CLKS_IN=
_RESET,
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap3xxx_gpio6_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap3xxx_gpio6_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "gpio6_ick",
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
