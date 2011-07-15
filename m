From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: powerdomains: Make all powerdomain target states
 as ON at init
Date: Fri, 15 Jul 2011 01:54:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107150152590.16606@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36013 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964863Ab1GOHyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 03:54:50 -0400
In-Reply-To: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

On Wed, 13 Jul 2011, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Program all powerdomain target state as ON; This is to
> prevent domains from hitting low power states (if bootloader
> has target states set to something other than ON) and potentially
> even losing context while PM is not fully initilized.
> The PM late init code can then program the desired target
> state for all the power domains.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, dropped the second hunk of the patch and queued for 3.1-rc fixes 
at git://git.pwsan.com/linux-2.6 in the 'pwrdm_clkdm_fixes_3.1rc' branch.

Santosh, looks like this is missing a Signed-off-by: or similar from you.  
Do you want me to add it?


- Paul
