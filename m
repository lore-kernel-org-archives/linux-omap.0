From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP4: Boot up crash 2.6.31-rc6
Date: Mon, 24 Aug 2009 17:09:37 +0300
Message-ID: <20090824140937.GG5165@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29BE14@dbde02.ent.ti.com> <878whdma1w.fsf@deeprootsystems.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C14D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59094 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZHXOJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 10:09:47 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C14D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King <rmk@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090822 10:56]:
> Thanks Kevin!!
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > Sent: Friday, August 21, 2009 9:30 PM
> > To: Shilimkar, Santosh
> > Cc: Russell King; Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> > kernel@lists.arm.linux.org.uk
> > Subject: Re: [PATCH 0/2] ARM: OMAP4: Boot up crash 2.6.31-rc6
> > 
> > "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> > 
> > > Russell,
> > >
> > > On the mainline 2.6.31-rc6, OMAP4 boot is crashing. Also serial code in
> > the linux-next branch isn't merge correctly and needs reworked patches.
> > >
> > > Can you please see if they are ok?
> > 
> > After the fix I suggested on patch 2/2, I'm OK with these.
> > 
> > Tony, should I pull these into my fixes queue, or do you want to merge
> > them directly.  We will need them in your for-next branch to resolve
> > the problems in linux-next.
>  I will submit new version with you comment.

See also Kevin's updated patch that removes the uart platform_data for omaps.

Tony
