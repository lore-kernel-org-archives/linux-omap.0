From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 05/14] OMAP2+: mux: add support for PAD wakeup
 interrupts
Date: Mon, 12 Dec 2011 12:01:51 +0200
Message-ID: <1323684111.31914.27.camel@sokoban>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
	 <1323440857-385-6-git-send-email-t-kristo@ti.com>  <87sjktjq40.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50014 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1LLKBz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 05:01:55 -0500
In-Reply-To: <87sjktjq40.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

On Fri, 2011-12-09 at 15:13 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > OMAP mux now provides a service routine to parse pending wakeup events
> > and to call registered ISR whenever active wakeups are detected. 
> 
> Good.
> 
> > This routine is called directly from PRCM interrupt handler.
> 
> I think this comment is out of date with the code, since you're now
> using a shared IRQ and the interrupt is directly called from the IRQ
> core.
> 
> I'd update the changelog here just commenting on what this IRQ is shared
> with, and how the interrupts are shared.
> 
> Also, a question on optimization.  For every IO wakeup, this will go
> through the list of *all* enabled hwmods.  This could be pretty expensive
> with lots of wakeups.  Maybe we should have another flag for hwmods that
> have wakeups enabled so walking the list of potential wakeup-capable
> hwmods will be as fast as possible.

Optimization of this code is sure possible, and probably even desirable.
In some of the earlier sets I had a separate list for the pad scan, but
it was dropped out due to some comments. It would be possible to add
either a separate list for these within omap_hwmod / mux, or either a
flag which checks for enabled io wakeups.

-Tero


