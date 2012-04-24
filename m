From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: watchdog: fix !PM boot crash, disarm timer
 after hwmod reset
Date: Tue, 24 Apr 2012 11:39:21 +0530
Message-ID: <CAMQu2gwTtGLFaQnRs5CXdkqAf+SaOfBbSe2BxcaJNPJWhcEBOg@mail.gmail.com>
References: <1334353873-15972-1-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:44462 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab2DXGJn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 02:09:43 -0400
Received: by qatm19 with SMTP id m19so2649500qat.12
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 23:09:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Apr 21, 2012 at 2:29 AM, Paul Walmsley <paul@pwsan.com> wrote:
> cc Santosh
>
> Hi Kevin,
>
> Nice changelog!
>
> On Fri, 13 Apr 2012, Kevin Hilman wrote:
>
>> Without runtime PM enabled, hwmod needs to leave all IP blocks in an
>> enabled state by default so any driver access to the HW will succeed=
=2E
>> This is accomplished by seting the postsetup_state to enabled for al=
l
>> hwmods during init when runtime PM is disabled.
>>
>> Currently, we have a special case for WDT in that its postsetup_stat=
e
>> is always set to disabled. =A0This is done so that the WDT is disabl=
ed
>> and the timer is disarmed at boot in case there is no WDT driver.
>> This also means that when runtime PM is disabled, if a WDT driver *i=
s*
>> built in the kernel, the kernel will crash on the first access to th=
e
>> WDT hardware.
>>
>> We can't simply leave the WDT module enabled, because the timer is
>> armed by default after reset. That means that if there is no WDT
>> driver initialzed or loaded before the timer expires, the kernel wil=
l
>> reboot.
>>
>> To fix this, a custom reset method is added to the watchdog class of
>> omap_hwmod. =A0This method will *always* disarm the timer after hwmo=
d
>> reset. =A0The WDT timer then will only be rearmed when/if the driver=
 is
>> loaded for the WDT. =A0With the timer disarmed by default, we no lon=
ger
>> need a special-case for the postsetup_state of WDT during init, so i=
t
>> is removed.
>>
>> Any platforms wishing to ensure the watchdog remains armed across th=
e
>> entire boot boot can simply disable the reset-on-init feature of the
>> watchdog hwmod using omap_hwmod_no_setup_reset().
>>
>> Tested on 3530/Overo, 4430/Panda.
>>
>> NOTE: on 4430, the hwmod OCP reset does not seem to rearm the timer =
as
>> documented in the TRM (and what happens on OMAP3.) =A0I noticed this
>> because testing the HWMOD_INIT_NO_RESET feature with no driver loade=
d,
>> I expected a reboot part way through the boot, but did not see a
>> reboot. =A0Adding some debug to read the counter, I verified that ri=
ght
>> after OCP softreset, the counter is not firing. =A0After writing the
>> magic start sequence, the timer starts counting. =A0This means that =
the
>> timer disarm sequence added here does not seem to be needed for 4430=
,
>> but is technically the correct way to ensure the timer is disarmed, =
so
>> it is left in for OMAP4.
>>
>> Special thanks to Paul Walmsley for helping brainstorm ideas to fix
>> this problem.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> This looks great, looks like it will finally fix this longstanding bu=
g. =A0I
> think Santosh hit it too a long time ago, so I suspect he will be hap=
py
> too.
>
Indeed !!
Thanks a lot Kevin/Paul for getting this sorted out.

=46WIW,
Acked-by: Santosh Shilimkar ,santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
