From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Thu, 7 Jun 2012 06:59:05 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061309.25532.13430.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58921 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989Ab2FGG7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:59:13 -0400
In-Reply-To: <20120607061309.25532.13430.stgit@dusk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, Jun 07, 2012 at 11:43:10, Paul Walmsley wrote:
> Kevin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
> ("ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod
> database") broke CORE idle on OMAP3.  This prevents device low power
> states.
> 
> The root cause is that the 32K sync timer IP block does not support
> smart-idle mode[1], and so the hwmod code keeps the IP block in
> no-idle mode while it is active.  This in turn prevents the WKUP
> clockdomain from transitioning to idle.  There is a hardcoded sleep
> dependency that prevents the CORE_L3 and CORE_CM clockdomains from
> transitioning to idle when the WKUP clockdomain is active[2], so the
> chip cannot enter any device low power states.
> 
> It turns out that there is no need to take the 32k sync timer out of
> idle.  The IP block itself probably does not have any native idle
> handling at all, due to its simplicity.  Furthermore, the PRCM will
> never request target idle for this IP block while the kernel is
> running, due to the sleep dependency that prevents the WKUP
> clockdomain from idling while the CORE_L3 clockdomain is active.  So
> we can safely leave the 32k sync timer in target-no-idle mode, even
> while we continue to access it.
> 
> This workaround is implemented by programming the force-idle mode for
> any IP block that only supports the force-idle and no-idle modes.  If
> an IP block is ever released that doesn't support smart-idle and
> requires no-idle mode to be programmed while it's in use, we'll have
> to change this behavior.
> 

Isn't this impact AM33xx devices, where we do not support smart idle mode???
Anyway, I will also test it on both OMAP3EVM and AM33xx platform now...

Thanks,
Vaibhav

