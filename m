From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
Date: Fri, 3 Aug 2012 09:21:17 +0200
Message-ID: <76308EBE-F802-411A-973A-7BBC7575FE5A@dominion.thruhere.net>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com> <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com> <501B7AE6.8080405@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36356 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab2HCHVV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 03:21:21 -0400
Received: by eeil10 with SMTP id l10so82920eei.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 00:21:20 -0700 (PDT)
In-Reply-To: <501B7AE6.8080405@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, ccross@android.com, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>


Op 3 aug. 2012, om 09:16 heeft Daniel Mack <zonque@gmail.com> het volgende geschreven:

> On 30.03.2012 15:27, Santosh Shilimkar wrote:
>> For coupled cpuidle to work when both cpus are active, it needs a global timer
>> that can handle events for both cpus.  This timer is used as the broadcast
>> clock-event when the per-cpu timer hardware stop in low power states.
>> Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
>> set the irq to allow the clockevent core to determine the affinity of the
>> timer.
> 
> These patches made it to mainline now, shortly befor 3.6-rc1, and it
> breaks boot on my AM33xx board.
> 
> Once I revert 1/3, the board boots again but crashes with the Ooops
> below. With the entire series reverted, everything works again as
> expected. Any idea?
> 
> The upstream commit ids are
> 
> 11d6ec2e "ARM: OMAP: timer: allow gp timer clock-event to be used on
> both cpus"
> 5b4d5bcc "ARM: OMAP4: CPUidle: add synchronization for coupled idle states"
> b93d70ae "ARM: OMAP4: CPUidle: Open broadcast clock-event device."

I've had boot problems with cpuidle enabled as well, what happens if you disable it? Is the revert still needed in that case? I'd really want cpufreq and cpuidle to work properly, but right now I'll settle for "it boots".

regards,

Koen