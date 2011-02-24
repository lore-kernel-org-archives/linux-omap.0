From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmod right before timer init
Date: Thu, 24 Feb 2011 01:18:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102240115300.6198@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <20110223071153.5874.58923.stgit@twilight.localdomain> <5A47E75E594F054BAF48C5E4FC4B92AB037A095471@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41536 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab1BXIS2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 03:18:28 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A095471@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hello Tarun

On Wed, 23 Feb 2011, DebBarma, Tarun Kanti wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Wednesday, February 23, 2011 12:42 PM
> > To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: Tony Lindgren; Hilman, Kevin; Shilimkar, Santosh; Cousson, Benoit
> > Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
> > hwmod right before timer init
> I am not able to apply this patch.
> Patch 1-7 applied successfully on top of:
> 04aa67d  Merge branch 'for-tony' of git://gitorious.org/usb/usb into omap-for-linus

Thanks, it seems that there was a stray header change left in my original 
tree.  The updated version is here:

   http://marc.info/?l=linux-omap&m=129853532211359&w=2


- Paul
