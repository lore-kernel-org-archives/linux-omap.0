From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 3/7] OMAP2+: PM: Initialise sleep_switch to a non-valid
 value
Date: Thu, 7 Jul 2011 16:36:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107071635230.2647@utopia.booyaka.com>
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com> <1309555626-22608-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51322 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1GGWgv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 18:36:51 -0400
In-Reply-To: <1309555626-22608-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

cc'ing Kevin, since this touches mach-omap2/pm.c - an ack would be great 
if you have the chance

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> sleep_switch which is initialised to 0 in omap_set_pwrdm_state
> happens to be a valid sleep_switch type (FORCEWAKEUP_SWITCH)
> which are defined as:
> 
>  #define FORCEWAKEUP_SWITCH      0
>  #define LOWPOWERSTATE_SWITCH    1
> 
> This causes the function to wrongly program some clock domains
> even when the Powerdomain is in ON state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'powerdomain_fixes_3.1' branch.


- Paul
