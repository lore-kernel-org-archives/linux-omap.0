From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 4/7] OMAP2+: PM: idle clkdms only if already in idle
Date: Thu, 7 Jul 2011 16:37:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107071636540.2647@utopia.booyaka.com>
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com> <1309555626-22608-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51333 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab1GGWh1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 18:37:27 -0400
In-Reply-To: <1309555626-22608-5-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

cc'ing Kevin, since this touches mach-omap2/pm.c - an ack would be great  
if you have the chance

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> The omap_set_pwrdm_state function forces clockdomains
> to idle, without checking the existing idle state
> programmed, instead based solely on the HW capability
> of the clockdomain to support idle.
> This is wrong and the clockdomains should be idled
> post a state_switch *only* if idle transitions on the
> clockdomain were already enabled.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'powerdomain_fixes_3.1' branch.


- Paul
