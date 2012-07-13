From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP4: twl-common: Support for additional devices
 on i2c1 bus
Date: Fri, 13 Jul 2012 05:14:21 -0500
Message-ID: <CAOMWX4e81gKYa_j8DHE_dn06+JfLwfEPuyj5kYVmDUBdG0n-1A@mail.gmail.com>
References: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47914 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755683Ab2GMKOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 06:14:44 -0400
Received: by wibhn17 with SMTP id hn17so307192wib.5
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 03:14:41 -0700 (PDT)
In-Reply-To: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 13, 2012 at 3:38 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related devices.
> Manufacturers can opt to use different codec than twl6040 and also can add
> audio related IC to the bus (external amplifier for example on SDP4430).
>
> Make it possible to add differnet set of additional devices to i2c1 bus on
> OMAP4 boards.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>
> Changes since v1:
> Generated against l-o/master
>
> Regards,
> Peter
>
>  arch/arm/mach-omap2/board-4430sdp.c    |   12 +++++++++-
>  arch/arm/mach-omap2/board-omap4panda.c |   12 +++++++++-
>  arch/arm/mach-omap2/twl-common.c       |   35 +++++++++----------------------
>  arch/arm/mach-omap2/twl-common.h       |    3 +-
>  4 files changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index ad8a7d9..26466f2 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -547,6 +547,14 @@ static struct twl6040_platform_data twl6040_data = {
>         .irq_base       = TWL6040_CODEC_IRQ_BASE,
>  };
>
> +static struct i2c_board_info __initdata sdp4430_i2c_1_boardinfo[] = {
> +       {
> +               I2C_BOARD_INFO("twl6040", 0x4b),
> +               .irq = OMAP44XX_IRQ_SYS_2N,
> +               .platform_data = &twl6040_data,
> +       },
> +};
> +
>  static struct twl4030_platform_data sdp4430_twldata = {
>         /* Regulators */
>         .vusim          = &sdp4430_vusim,
> @@ -580,8 +588,8 @@ static int __init omap4_i2c_init(void)
>                         TWL_COMMON_REGULATOR_CLK32KG |
>                         TWL_COMMON_REGULATOR_V1V8 |
>                         TWL_COMMON_REGULATOR_V2V1);
> -       omap4_pmic_init("twl6030", &sdp4430_twldata,
> -                       &twl6040_data, OMAP44XX_IRQ_SYS_2N);
> +       omap4_pmic_init("twl6030", &sdp4430_twldata, sdp4430_i2c_1_boardinfo,
> +                       ARRAY_SIZE(sdp4430_i2c_1_boardinfo));

We still need a way to switch to I2C highspeed mode
omap4_pmic_init still does register in 400KHz mode, while setting a bit in 6040
should let us talk 3.3MHz on the bus.

Regards,
Nishanth Menon
