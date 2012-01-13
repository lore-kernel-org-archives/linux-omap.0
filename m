From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Fri, 13 Jan 2012 16:19:35 +0100
Message-ID: <4F104B87.8080003@ti.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54994 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758292Ab2AMPTr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 10:19:47 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1/13/2012 1:21 PM, Hiremath, Vaibhav wrote:
> Hi,
>
> In case of AM33xx family of devices, we do not have 32K Sync timer
> (32K Counter) available; and the current implementation is based on
> compile-time option, where clock-source is chosen by something like,
>
> File - arch/arm/mach-omap2/timer.c
>
> #ifdef CONFIG_OMAP_32K_TIMER
> static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> {
> ...
> }
> #else
> static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> {
> ...
> }
> #endif
>
>
> But in order to support multi-omap build, we must
> make run-time decision to use the timer for kernel clock-source, either of -
>
>   - DMTIMER
>   - 32K Sync Timer
>
> The DMTIMER is already migrated to the HWMOD framework, but 32K Timer code
> has not yet migrated to it. So the question here is,

A series was sent to do that by Felipe last year, but we somehow forgot 
to rebase it on newer kernel and thus never reposted it.

Benoit
