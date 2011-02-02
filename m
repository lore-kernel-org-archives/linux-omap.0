From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
 boot failure)
Date: Wed, 2 Feb 2011 11:48:56 -0800
Message-ID: <20110202194855.GA3322@atomide.com>
References: <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
 <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com>
 <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com>
 <20110111231611.GX4957@atomide.com>
 <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
 <20110202011006.GP3358@atomide.com>
 <81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38165 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab1BBTtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 14:49:13 -0500
Content-Disposition: inline
In-Reply-To: <81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110201 22:04]:
> >
> > It's a ES1.0 blaze, with the patch below it reboots early
> > during the boot. I also have to disable omap_l2_cache_init
> > on this board to get it to boot.
> >
> Do you still get this problem with 'omap_l2_cache_init' ?
> As reported earlier, we don't see this issue on ES1.0
> SDP.

Yeah I do, it rarely makes it to the userspace. Works reliably
if I disable omap_l2_cache_init.

Tony
