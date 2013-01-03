From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2+: Disable code that currently does not
 work with multiplaform
Date: Thu, 3 Jan 2013 14:49:54 -0800
Message-ID: <20130103224954.GJ25633@atomide.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
 <20121219192627.22098.10760.stgit@muffinssi.local>
 <20130103201521.GI25633@atomide.com>
 <2770938.Qr8SHcYrK2@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35312 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754040Ab3ACWuH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 17:50:07 -0500
Content-Disposition: inline
In-Reply-To: <2770938.Qr8SHcYrK2@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Sean Young <sean@mess.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, =?utf-8?Q?V=C3=ADctor_Manuel_J=C3=A1quez?= Leal <vjaquez@igalia.com>, Herbert Xu <herbert@gondor.apana.org.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [130103 13:25]:
> Hi Tony,
> 
> On Thursday 03 January 2013 12:15:21 Tony Lindgren wrote:
> > Hi all,
> > 
> > Looks like we need to also disable mailbox to avoid dependencies to
> > the mailbox series as it's being moved to live under drivers.
> > 
> > And we need to disable omap3isp as it tries to use the now private
> > include <plat/*.h> headers.
> 
> I've posted a patch to the linux-media mailing list to remove plat/*.h headers 
> that are not present anymore in v3.8. It will be pushed to v3.8, as this 
> breaks compilation of the driver.

Great, thanks for doing that.
 
> The driver still includes the plat/cpu.h header that can be removed as well. 
> I've just posted a patch that remove the header and will push it to v3.9. The 
> OMAP3 ISP part of this patch can thus be dropped.

OK. I suggest you merge the plat/cpu.h during the -rc cycle as well.
With v3.8-rc2 plat/cpu.h no longer contains anything for omap2+, and
we could make it now to do #error for omap2+ if the current users
are fixed.

Will drop the omap3isp part from this patch as you suggested though.

Regards,

Tony
