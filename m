From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] mach-omap2/board-igep0020.c: Fix reboot problem
Date: Thu, 15 Nov 2012 10:42:36 -0600
Message-ID: <CAOCHtYjt7v-nB_8xsS29jPOmvFD847PRLu3QBz7n94VGphFoyw@mail.gmail.com>
References: <1352995613-17994-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40750 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768379Ab2KOQmh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 11:42:37 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1856344vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 08:42:36 -0800 (PST)
In-Reply-To: <1352995613-17994-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@googlemail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, martinez.javier@gmail.com, eballetbo@iseebcn.com, Matthias Brugger <matthias.bgg@gmail.com>

On Thu, Nov 15, 2012 at 10:06 AM, Matthias Brugger
<matthias.bgg@googlemail.com> wrote:
> When rebooting an OMAP3530 at 125 MHz, the reboot hangs.
> This patch adds a generic power save script, which resets the TWL4030 when a
> warm reset occures. This way the OMAP3530 does not hang on reboot.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |   36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 48d5e41..9ba1c4b 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -487,11 +487,47 @@ static struct twl4030_keypad_data igep2_keypad_pdata = {
>         .rep            = 1,
>  };
>
> +static struct twl4030_ins wrst_seq[] __initdata = {
> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
> +       {MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
> +       {MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
> +       {MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
> +       {MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
> +};
> +
> +static struct twl4030_script wrst_script __initdata = {
> +       .script = wrst_seq,
> +       .size   = ARRAY_SIZE(wrst_seq),
> +       .flags  = TWL4030_WRST_SCRIPT,
> +};
> +
> +static struct twl4030_script *twl4030_scripts[] __initdata = {
> +       &wrst_script,
> +};
> +
> +static struct twl4030_resconfig twl4030_rconfig[] = {
> +       { .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
> +               .type2 = -1 },
> +       { .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
> +               .type2 = -1 },
> +       { .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
> +               .type2 = -1 },
> +       { 0, 0},
> +};
> +
> +static struct twl4030_power_data igep_twl4030_power_data = {
> +       .scripts        = twl4030_scripts,
> +       .num            = ARRAY_SIZE(twl4030_scripts),
> +       .resource_config = twl4030_rconfig,
> +};
> +
>  static struct twl4030_platform_data igep_twldata = {
>         /* platform_data for children goes here */
>         .gpio           = &igep_twl4030_gpio_pdata,
>         .vmmc1          = &igep_vmmc1,
>         .vio            = &igep_vio,
> +       .power          = &igep_twl4030_power_data,
>  };
>
>  static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] = {
> --
> 1.7.9.5
>
> --

Sweet, this also fixes the software reboot lockup I've been bisecting
on the Beagle C4 (omap3530), when the ONDEMAND governor is enabled..
(applied the same changes to the beagle's board file:
board-omap3beagle.c)

Can we make this script generic for all omap35xx/twl4030 boards that need it?

So far, no regressions in a quick boot/reboot test of DM3730 Beagle xM
C that shares the board file...

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
