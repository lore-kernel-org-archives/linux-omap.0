From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/2] ARM: OMAP4: Boot up crash 2.6.31-rc6
Date: Sat, 22 Aug 2009 13:26:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C14D@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29BE14@dbde02.ent.ti.com>
 <878whdma1w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54122 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbZHVH4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 03:56:23 -0400
In-Reply-To: <878whdma1w.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Thanks Kevin!!

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, August 21, 2009 9:30 PM
> To: Shilimkar, Santosh
> Cc: Russell King; Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.arm.linux.org.uk
> Subject: Re: [PATCH 0/2] ARM: OMAP4: Boot up crash 2.6.31-rc6
> 
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> 
> > Russell,
> >
> > On the mainline 2.6.31-rc6, OMAP4 boot is crashing. Also serial code in
> the linux-next branch isn't merge correctly and needs reworked patches.
> >
> > Can you please see if they are ok?
> 
> After the fix I suggested on patch 2/2, I'm OK with these.
> 
> Tony, should I pull these into my fixes queue, or do you want to merge
> them directly.  We will need them in your for-next branch to resolve
> the problems in linux-next.
 I will submit new version with you comment.
