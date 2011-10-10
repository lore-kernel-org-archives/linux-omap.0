From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: timer fixes / cleanup
Date: Mon, 10 Oct 2011 15:35:40 +0530
Message-ID: <CAC83ZvLd27nER5z1R1L27KFR4CQ1mwhmQ18BR7OCBZEDtNFWYg@mail.gmail.com>
References: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
	<4E8B7C6A.2050207@ti.com>
	<CAC83Zv+r0emW7rREkPhjPyn_jBCbNLXKCNTY0=vMNxCTzzp=Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53660 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752511Ab1JJKFm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 06:05:42 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so10741001bkb.40
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 03:05:41 -0700 (PDT)
In-Reply-To: <CAC83Zv+r0emW7rREkPhjPyn_jBCbNLXKCNTY0=vMNxCTzzp=Xg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 10, 2011 at 11:10 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Wed, Oct 5, 2011 at 3:06 AM, Cousson, Benoit <b-cousson@ti.com> wr=
ote:
>> Hi Tarun,
>>
>> On 10/4/2011 11:20 PM, Cousson, Benoit wrote:
>>>
>>> Hi Tony,
>>>
>>> Here is the series to fix the warning and remove the redundant
>>> latency structure that be removed since the timer runtime PM
>>> adaptation was just pulled.
>>>
>>> I was just able to test that on OMAP4.
>>
>> It will be nice if you can test that on the other platforms.
>> In theory, if they are properly using hwmod that should work fine.
> Yes, I will test in other platforms.
I have tested on OMAP2420, OMAP2430 and OMAP3430.
--
Tarun

>> Thanks,
>> Benoit
>>
>>>
>>> Patches are based on Kevin's for_3.2/omap_device-2 branch
>>> and are available here:
>>> git://gitorious.org/omap-pm/linux.git for_3.2/timer_fixes
>>>
>>> Regards,
>>> Benoit
>>>
>>>
>>> Benoit Cousson (2):
>>> =A0 ARM: OMAP2+: clock data: Remove redundant timer clkdev
>>> =A0 ARM: OMAP2+: timer: Remove omap_device_pm_latency
>>>
>>> =A0arch/arm/mach-omap2/clock2420_data.c | =A0 12 ------------
>>> =A0arch/arm/mach-omap2/clock2430_data.c | =A0 12 ------------
>>> =A0arch/arm/mach-omap2/clock3xxx_data.c | =A0 12 ------------
>>> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 11 -----------
>>> =A0arch/arm/mach-omap2/timer.c =A0 =A0 =A0 =A0 =A0| =A0 12 +-------=
----
>>> =A05 files changed, 1 insertions(+), 58 deletions(-)
>>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
