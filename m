From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Tue, 17 Apr 2012 00:42:06 +0530
Message-ID: <CAC83ZvJJ8QQhQXq94n-Q7i=WCzdnT1q49huiRscz=mcO2zMLtg@mail.gmail.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
	<1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
	<79CD15C6BA57404B839C016229A409A83E9EE79A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55783 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754583Ab2DPTMI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 15:12:08 -0400
Received: by qcsg15 with SMTP id g15so4004679qcs.13
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 12:12:06 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9EE79A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Mon, Apr 16, 2012 at 8:33 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
> On Mon, Apr 16, 2012 at 17:55:24, DebBarma, Tarun Kanti wrote:
>> We do not use iclk anywhere in the dmtimer driver and so removing it=
=2E
>> Hence removing the timer iclk entries from OMAP4 clkdev table as wel=
l.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0| =A0 11 --------=
---
>> =A0arch/arm/mach-omap2/timer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
7 -------
>> =A0arch/arm/plat-omap/include/plat/dmtimer.h | =A0 =A02 +-
>> =A03 files changed, 1 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-om=
ap2/clock44xx_data.c
>> index fa6ea65..2172f66 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -3355,17 +3355,6 @@ static struct omap_clk omap44xx_clks[] =3D {
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "auxclk5_ck", =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &auxclk5_ck, =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "auxclkreq5_ck", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&auxclkreq5_ck, CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpmc_ck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt1_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt2_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt3_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt4_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt5_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt6_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt7_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt8_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt9_ick", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt10_ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt11_ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK("omap_i2c.1", =A0 =A0 =A0 "ick", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK("omap_i2c.2", =A0 =A0 =A0 "ick", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK("omap_i2c.3", =A0 =A0 =A0 "ick", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer=
=2Ec
>> index c512bac..5d7a0ee 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -169,13 +169,6 @@ static int __init omap_dm_timer_init_one(struct=
 omap_dm_timer *timer,
>> =A0 =A0 =A0 if (IS_ERR(timer->fclk))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> - =A0 =A0 sprintf(name, "gpt%d_ick", gptimer_id);
>> - =A0 =A0 timer->iclk =3D clk_get(NULL, name);
>> - =A0 =A0 if (IS_ERR(timer->iclk)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(timer->fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> - =A0 =A0 }
>> -
>
> Doesn't this impact OMAP3x family?
> The interface clocks will be enabled in omap_hwmod_enable(),
> only if you set OCPIF_SWSUP_IDLE flag.
Please note that gptX_ick definitions are still intact in
clock3xxx_data.c and omap_hwmod_3xxx_data.c.
At least I have not observed impact of removing this on OMAP3430SDP tes=
ting.
--
Tarun
>
> Thanks,
> Vaibhav
>
>> =A0 =A0 =A0 omap_hwmod_enable(oh);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
