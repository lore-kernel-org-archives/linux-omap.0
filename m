From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/6] ARM: OMAP3: PRM: move prcm interrupt handlers to PRM
 driver code
Date: Tue, 7 Aug 2012 00:28:52 -0700
Message-ID: <20120807072852.GN11011@atomide.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
 <1342197459-7920-2-git-send-email-t-kristo@ti.com>
 <87ipd4g4a5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14290 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab2HGH2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:28:55 -0400
Content-Disposition: inline
In-Reply-To: <87ipd4g4a5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120730 17:36]:
> 
> At first, I wasn't sure why this was happening on Overo boards and not
> on the other boards, but then I notcied there was a *lot* more pm_wkup
> interrupts during boot on Overo compared to the other boards.  This is
> because of the GPIO IRQ for the network interface as well as the network
> stack itself setting timers, resulting in a lot more pm_wkup events
> during boot and making the race more likely.

Also happens if you may have somehow both edges selected for GPIO
interrupts. Might be worth checking at least just in case of bugs
somewhere..

Tony
