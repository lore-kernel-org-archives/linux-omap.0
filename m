From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Reclaim address space on omaps, Tony on vacation in July
Date: Fri, 26 Jun 2009 13:14:03 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E4C7D46@dlee02.ent.ti.com>
References: <20090626062539.GX7352@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B53AB55D@dbde02.ent.ti.com>
 <20090626084633.GD7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56491 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZFZSOW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 14:14:22 -0400
In-Reply-To: <20090626084633.GD7352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren

> > > Last week I posted some more omap io.h clean-up patches to
> > > the linux-omap
> > > list [1], and started looking at what it would take to
> > > reclaim lost address
> > > space on top of the io.h clean-up patches.
> > >
> > > Looks like we should be able to reclaim about 454MB of the 640MB
> > > of the lost IO address space by doing the following:

Using section entries to cover ranges provides superior performance.  1 TLB will cover a whole series of accesses when doing things like servicing an interrupt.  Using fewer TLBs to cover system accesses leaves more in tact for application usage.  I've not see recent data but long back TLB optimization provided sizeable performance boost for many applications.

Additionally debug is simplified by having the simple static map around.

Russell recently pointed out and David showed an example of how ioremap() can take an arch specific function which can return virtual address from already defined static ranges.  I do think this is a nice clean up and optimization (to stop some double mapping which now happens with ioremap).

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg03813.html

So, I think yes moving to ioremap in all drivers is good, but it would use underlying static maps where they exist.

It might be not _all_ ranges need to be fully static mapped, but the common device ones should be.

On this thread there has been a mounting request for more physical memory.  Starting to make a 2x2gig split option and perhaps understanding more how to use extended addressing like xscale is doing would be good road map stuff.

If io.h is getting messy maybe it should be broken in to a couple files... Anyway, driver cleanup using common ioremap would be the big winner.

Regards,
Richard W.

