From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
Date: Sun, 31 May 2015 21:18:42 -0500
Message-ID: <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com> <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36857 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbbFACTE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 May 2015 22:19:04 -0400
In-Reply-To: <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>

On Sun, May 31, 2015 at 7:20 PM, Matthijs van Duin
<matthijsvanduin@gmail.com> wrote:
> Sorry for the late response, I only just noticed this since I wasn't CC'd.
>
> This "fix" was not ever Reported-By or Tested-By me as it claims. It
> is in fact wrong: &rtc { system-power-controller; } needs to be
> present for every variety of beaglebone (more generally every design
> with a TPS65217 whose PWR_EN is connected to the PMIC_POWER_EN pin of
> an AM335x).
>
> Without a system-power-controller, the kernel has no way of turning
> off the system and shutdown will leave the system halted instead.
>
> The previously posted fix, which added  &tps {
> ti,pmic-shutdown-controller; }  was correct, and ensures that a
> poweroff makes the pmic enter "OFF-state" rather than "SLEEP-state"
> (aka RTC-only sleep).

Sorry Matthijs, (and everyone else)

That's my fault for completely screwing up this patch..

Revert:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3d76be5b933e2a66d85a2f7444e68e99e8a48ad4

Then use:
http://www.spinics.net/lists/linux-omap/msg118512.html

With the update commit message:

Fixes: http://bugs.elinux.org/issues/143

Entering RTC-only sleep is only properly supported on early prototypes
series (pre-A6) of the BeagleBone Black. Since rev (A6A), which
include all production versions, it is not support at due to.

(rev A6) enable of the 3v3b regulator moved from LDO2 to LDO4 (3v3a)
side-effect: 3v3b rail remains on in sleep-mode (also in off-mode when
battery-powered)

(rev A6A) am335x vdds supply moved from LDO3 to LDO1 side-effect: vdds
remains supplied in sleep-mode

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
