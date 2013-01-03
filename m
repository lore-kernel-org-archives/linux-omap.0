From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2+: Disable code that currently does not
 work with multiplaform
Date: Thu, 3 Jan 2013 15:00:38 -0800
Message-ID: <20130103230038.GL25633@atomide.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
 <2770938.Qr8SHcYrK2@avalon>
 <20130103224954.GJ25633@atomide.com>
 <2553128.bVQFtBdOtK@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41633 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753575Ab3ACXAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 18:00:49 -0500
Content-Disposition: inline
In-Reply-To: <2553128.bVQFtBdOtK@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Sean Young <sean@mess.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, =?utf-8?Q?V=C3=ADctor_Manuel_J=C3=A1quez?= Leal <vjaquez@igalia.com>, Herbert Xu <herbert@gondor.apana.org.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [130103 14:54]:
> On Thursday 03 January 2013 14:49:54 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [130103 13:25]:
> > >
> > > The driver still includes the plat/cpu.h header that can be removed as
> > > well. I've just posted a patch that remove the header and will push it to
> > > v3.9. The OMAP3 ISP part of this patch can thus be dropped.
> > 
> > OK. I suggest you merge the plat/cpu.h during the -rc cycle as well.
> > With v3.8-rc2 plat/cpu.h no longer contains anything for omap2+, and
> > we could make it now to do #error for omap2+ if the current users
> > are fixed.
> 
> If Mauro is fine with the patch going to v3.8-rc I have no issue with that. Is 
> this patch targetted at v3.8 or v3.9 ?

Well ideally ASAP to prevent new drivers including plat/cpu.h as otherwise
build breakage will occur when we flip on the multiplatform support :)

Regards,

Tony 
