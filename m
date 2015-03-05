From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: reboot command fails with low frequency
Date: Thu, 5 Mar 2015 14:25:51 +0200
Message-ID: <CAJ2oMhJk9_Hdov4ue-8WWNbEaDh862GhbYWwBtaUZTdbbFkWbQ@mail.gmail.com>
References: <CAJ2oMhLDbA_BVsZPnbNq460mYbUw6Z7QpB=YmSCjX65NL1BaFg@mail.gmail.com>
	<CAOf5uwkWvd_gH08t-AacU8Jp4gFmr4X42bMv4eT43Uhaaa5GMQ@mail.gmail.com>
	<CAJ2oMh+HC7wuZ6+F7jXe9hGe68=WWsu5=H1h0OZanEUs6HqxzQ@mail.gmail.com>
	<CAOf5uwmyOZOTMBGnQU38-D=Emo6Rdrd8fDW9Hk+_r4RG4=+nrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:39674 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723AbbCEMZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 07:25:52 -0500
In-Reply-To: <CAOf5uwmyOZOTMBGnQU38-D=Emo6Rdrd8fDW9Hk+_r4RG4=+nrA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org

On Thu, Mar 5, 2015 at 12:58 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> You should find the twl4030 power script and you should have something like this
>
> static struct twl4030_ins wrst_seq[] __initdata = {
>         {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
>         {MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
>         {MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
>         {MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
>         {MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
>         {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
> };
>
> static struct twl4030_script wrst_script __initdata = {
>         .script = wrst_seq,
>         .size   = ARRAY_SIZE(wrst_seq),
>         .flags  = TWL4030_WRST_SCRIPT,
> };
>
> static struct twl4030_script *omap3_power_scripts[] __initdata = {
>         &wrst_script,
> };
>
> If I remember it was solved by some change here. In my old kernel I
> have this commit
>
>  Fix the reboot at lower frequency
>
>     Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> diff --git a/arch/arm/mach-omap2/board-panther.c
> b/arch/arm/mach-omap2/board-panther.c
> index ad2adf3..c71fdd9 100644
> --- a/arch/arm/mach-omap2/board-panther.c
> +++ b/arch/arm/mach-omap2/board-panther.c
> @@ -368,7 +368,7 @@ static int __init panther_i2c_init(void)
>  {
>         omap3_pmic_get_config(&panther_twldata,
>                         TWL_COMMON_PDATA_MADC |
> -                       TWL_COMMON_PDATA_AUDIO,
> +                       TWL_COMMON_PDATA_AUDIO | TWL_COMMON_PDATA_POWER,
>                         TWL_COMMON_REGULATOR_VDAC);
>
>         omap3_pmic_init("twl4030", &panther_twldata);
>
> But this apply on an old device with a newer kernel and I don't
> remember now the reason ;) Sorry.
>
> Is this an android device? (2.6.37??? is really old)
>
I have something quite different in my code:

static int __init twl4030_config_warmreset_sequence(u8 address)
{
int err;
u8 rd_data;

/* Set WARM RESET SEQ address for P1 */
err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
R_SEQ_ADD_WARM);
if (err)
goto out;

/* P1/P2/P3 enable WARMRESET */
err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
R_P1_SW_EVENTS);
if (err)
goto out;

rd_data |= ENABLE_WARMRESET;
err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
R_P1_SW_EVENTS);
if (err)
goto out;

err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
R_P2_SW_EVENTS);
if (err)
goto out;

rd_data |= ENABLE_WARMRESET;
err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
R_P2_SW_EVENTS);
if (err)
goto out;

err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
R_P3_SW_EVENTS);
if (err)
goto out;

rd_data |= ENABLE_WARMRESET;
err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
R_P3_SW_EVENTS);
out:
if (err)
pr_err("TWL4030 warmreset seq config error\n");
return err;
}

And the board is TI's board_omap3evm.c.

Ran
