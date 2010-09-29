From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 00/11] OMAP3: Adding Smartreflex and Voltage driver support
Date: Tue, 28 Sep 2010 18:02:40 -0700
Message-ID: <87iq1p745r.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<87eicd8k5p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39807 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab0I2BCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 21:02:43 -0400
Received: by pvg2 with SMTP id 2so52595pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 18:02:43 -0700 (PDT)
In-Reply-To: <87eicd8k5p.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Tue, 28 Sep 2010 17:31:46 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Thara Gopinath <thara@ti.com> writes:
>
>> From: thara gopinath <thara@ti.com>
>>
>> This patch series introduces smartreflex and voltage driver support
>> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
>> control for real-time voltage adjustments.
>
> [...]
>
>> This patch series is based against origin/pm-core branch off
>> Kevin's pm tree which in turn is based off lo-master.
>> This series will apply against lo-master also but will
>> break compilation due to lack of opp framework support
>> on lo-master.
>>
>> This patch series has been tested on OMAP3430 SDP with the extra five patches
>> from origin/cpufreq branch off Kevin's pm tree applied. This series
>> has been tested with with omap3_defconfig with the following
>> menuconfig options enabled.
>> System type -> TI OMAP Implementations -> Smartreflex Support
>> System type -> TI OMAP Implementations ->
>> 		Class 3 mode of Smartreflex Implementation
>
> Using the same baseline as you mention above (pm-core + pm-opp), I
> applied this series (and the OMAP4 series) and tested on 34xx/n900 and
> 36xx/Zoom3 using omap2plus_defconfig and it booted ok.  (I also patched
> the n900 board file to call sr_class3_init(), which you should include
> as part of the series too.)
>
> I then did some experiments, including updating the pm-sr branch to be
> this latest series and testing with omap3_pm_defconfig.  With that, I
> notcied that within a few seconds of reaching the shell, the system
> rebooted.
>
> I tracked this down to the fact that CONFIG_OMAP_WATCHDOG was not
> enabled in omap3_pm_defconfig.  Enabling the watchdog, and it no longer
> reboots.   /me confused
>
> Using just the pm-sr branch by itself and omap2plus_defconfig, even with
> the watchdog disabled, it doesn't reboot.
>
> Do you have any ideas what else might be causing this reboot when using
> the PM branch + omap3_pm_defconfig?

So, I did a little more digging, and this has nothing to do with your
series.  It has to do with the watchdog hwmod series, which due to the
new hwmods, resets the watchdog IP.  So, if a watchdog driver isn't
enabled, the watchdog will fire, and cause a reboot.

Kevin
