From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: reboot command fails with low frequency
Date: Thu, 5 Mar 2015 11:58:28 +0100
Message-ID: <CAOf5uwmyOZOTMBGnQU38-D=Emo6Rdrd8fDW9Hk+_r4RG4=+nrA@mail.gmail.com>
References: <CAJ2oMhLDbA_BVsZPnbNq460mYbUw6Z7QpB=YmSCjX65NL1BaFg@mail.gmail.com>
	<CAOf5uwkWvd_gH08t-AacU8Jp4gFmr4X42bMv4eT43Uhaaa5GMQ@mail.gmail.com>
	<CAJ2oMh+HC7wuZ6+F7jXe9hGe68=WWsu5=H1h0OZanEUs6HqxzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAJ2oMh+HC7wuZ6+F7jXe9hGe68=WWsu5=H1h0OZanEUs6HqxzQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

You should find the twl4030 power script and you should have something like this

static struct twl4030_ins wrst_seq[] __initdata = {
        {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
        {MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
        {MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
        {MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
        {MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
        {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
};

static struct twl4030_script wrst_script __initdata = {
        .script = wrst_seq,
        .size   = ARRAY_SIZE(wrst_seq),
        .flags  = TWL4030_WRST_SCRIPT,
};

static struct twl4030_script *omap3_power_scripts[] __initdata = {
        &wrst_script,
};

If I remember it was solved by some change here. In my old kernel I
have this commit

 Fix the reboot at lower frequency

    Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

diff --git a/arch/arm/mach-omap2/board-panther.c
b/arch/arm/mach-omap2/board-panther.c
index ad2adf3..c71fdd9 100644
--- a/arch/arm/mach-omap2/board-panther.c
+++ b/arch/arm/mach-omap2/board-panther.c
@@ -368,7 +368,7 @@ static int __init panther_i2c_init(void)
 {
        omap3_pmic_get_config(&panther_twldata,
                        TWL_COMMON_PDATA_MADC |
-                       TWL_COMMON_PDATA_AUDIO,
+                       TWL_COMMON_PDATA_AUDIO | TWL_COMMON_PDATA_POWER,
                        TWL_COMMON_REGULATOR_VDAC);

        omap3_pmic_init("twl4030", &panther_twldata);

But this apply on an old device with a newer kernel and I don't
remember now the reason ;) Sorry.

Is this an android device? (2.6.37??? is really old)

Michael

On Thu, Mar 5, 2015 at 10:29 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>>> We observer that with highest available frequency (600000) reboot
>>> command is OK, but when frequency is changed to lower value, the
>>> reboot command fails.
>>> Has anyone observed such behaviour ?
>>
>> I remember some commit for this problem. What version of the linux are
>> you running?
>
> I use Linux version 2.6.37 #36 PREEMPT Thu Mar 5 10:56:04 IST 2015
> armv7l GNU/Linux
>
> Do you know how I can find this fix ?
>
> Thanks!
> Ran



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
