From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP2+: Simplify system timers definitions
Date: Mon, 4 Feb 2013 09:27:43 -0600
Message-ID: <510FD36F.5090603@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com> <1359565471-30721-5-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40656 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432Ab3BDP1r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 10:27:47 -0500
In-Reply-To: <1359565471-30721-5-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 01/30/2013 11:04 AM, Jon Hunter wrote:
> There is a lot of redundancy in the definitions for the various system
> timers for OMAP2+ devices. For example, the omap3_am33xx_gptimer_timer_init()
> function is the same as the omap3_gp_gptimer_timer_init() function and the
> function omap2_sync32k_timer_init() can be re-used for OMAP4/5 devices.

After further testing, I have found that using the
omap2_sync32k_timer_init() for omap4/5 devices does not work for the
case where we boot with boot parameter "clocksource=gp_timer". The
problem is omap4/5 devices, unlike omap2/3 devices, does not have a
clock alias for "timer_sys_ck" with NULL as the device name. Therefore
we fail to find the parent clock and boot fails.

So I am going to update this patch so that omap4 and omap5 both use
omap4_sync32k_timer_init() and just get rid of the extra function
defined for omap5.

Hope this makes sense.

Cheers
Jon
