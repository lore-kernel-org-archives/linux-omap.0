From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2+: dmtimer: cleanup related to devm API and
 clk usage
Date: Tue, 17 Apr 2012 01:20:49 +0530
Message-ID: <CAC83Zv+pe6b71whtOJRaZYX=S5aMxSo4YBv0EqR2KJh5zK8uUA@mail.gmail.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
	<79CD15C6BA57404B839C016229A409A83E9EE723@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:41852 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754269Ab2DPTuv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 15:50:51 -0400
Received: by qabg40 with SMTP id g40so3644292qab.4
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 12:50:49 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9EE723@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Mon, Apr 16, 2012 at 8:23 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
> On Mon, Apr 16, 2012 at 17:55:22, DebBarma, Tarun Kanti wrote:
>> The devm API usage in probe() simplifies error handling operation.
>> Since iclk is not used in the driver it is removed from wherever
>> not needed. The fclk naming is made uniform as per OMAP4 platform,
>> viz. "timer1_fck", "timer2_fck", ... in all relevant places which
>> include hwmod database. With this change there is no more need to
>> construct clock names using sprintf() to be used in clk_get()
>> during initialization. Instead we can use oh->main_clk directly.
>>
> Correct me if I am wrong here, I believe there is no relation between
> naming of clock and sprintf; with the existing code you can still use
> oh>main_clk, isn't it?
Right. The only thing is we don't that anymore.

>
> Below code alone should work right, so that driver code is becomes
> independent of clock name.
>
> - =A0 =A0 =A0 sprintf(name, "gpt%d_fck", gptimer_id);
> - =A0 =A0 =A0 timer->fclk =3D clk_get(NULL, name);
> + =A0 =A0 =A0 timer->fclk =3D clk_get(NULL, oh->main_clk);
Yes. Of course, Paul has given alternate suggestion to using oh->main_c=
lk.
--
Tarun
>
>
> Thanks,
> Vaibhav
>
>> Reference:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)
>>
>> Series is available here for reference:
>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux=
-omap-dev dmtimer_cleanup_for_3.5
>>
>> Tested on following platforms:
>> OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
>> Could not test on OMAP2420 due to unavailability of board.
>>
>> Tarun Kanti DebBarma (3):
>> =A0 ARM: OMAP: dmtimer: Use devm_ API and do some cleanup in probe()
>> =A0 ARM: OMAP2+: dmtimer: cleanup iclk usage
>> =A0 ARM: OMAP2+: dmtimer: cleanup fclk usage
>>
>> =A0arch/arm/mach-omap2/clock2420_data.c =A0 =A0 =A0 | =A0 72 +++++++=
+++++++--------------
>> =A0arch/arm/mach-omap2/clock2430_data.c =A0 =A0 =A0 | =A0 72 +++++++=
+++++++--------------
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 72 +++++++=
+++++++--------------
>> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 | =A0 33 ++++---=
-----
>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0 24 +++++-----
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 24 +++++-----
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 24 +++++-----
>> =A0arch/arm/mach-omap2/timer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
10 +----
>> =A0arch/arm/plat-omap/dmtimer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 51=
 +++++++------------
>> =A0arch/arm/plat-omap/include/plat/dmtimer.h =A0| =A0 =A02 +-
>> =A010 files changed, 176 insertions(+), 208 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
