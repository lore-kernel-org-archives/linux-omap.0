From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check presence of 32k timer
Date: Mon, 23 Jan 2012 15:38:50 -0800
Message-ID: <87mx9ej8fp.fsf@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:44860 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558Ab2AWXiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 18:38:54 -0500
Received: by ggm4 with SMTP id 4so84818ggm.24
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 15:38:52 -0800 (PST)
In-Reply-To: <1326983304-14619-2-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Thu, 19 Jan 2012 19:58:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, johnstul@us.ibm.com, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> OMAP device has 32k-sync timer which is currently used as a
> clocksource in the kernel (omap2plus_defconfig).
> The current implementation uses compile time selection between
> gp-timer and 32k-sync timer, which breaks multi-omap build for
> the devices like AM33xx, where 32k-sync timer is not available.
>
> So use hwmod database lookup mechanism, through which at run-time
> we can identify availability of 32k-sync timer on the device,
> else fall back to gp-timer.

With the runtime detection & fallback, I suggest also removing the
Kconfig choice between the two as well.

Kevin
