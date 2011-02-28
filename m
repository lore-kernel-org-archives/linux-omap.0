From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
Date: Mon, 28 Feb 2011 23:47:39 +0530
Message-ID: <8d16615a6ede144f074a3c7387e70b2c@mail.gmail.com>
References: <E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk> <20110207120103.GC31929@n2100.arm.linux.org.uk>
 <20110207121052.GD31929@n2100.arm.linux.org.uk> <AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
 <20110207133457.GE31929@n2100.arm.linux.org.uk> <AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
 <20110207141734.GG31929@n2100.arm.linux.org.uk> <AANLkTimCtaSZ=CHT5snWZ496_bi4sH=0LU7vJ-Jfh=dP@mail.gmail.com>
 <20110211115853.GC23404@n2100.arm.linux.org.uk> <998315b4ab88b66cc0e32e73d10a0015@mail.gmail.com>
 <20110212145010.GK15616@n2100.arm.linux.org.uk> <3f574626437da8db9f7844d5bb031046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36078 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752805Ab1B1SRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 13:17:41 -0500
Received: by mail-qw0-f43.google.com with SMTP id 7so3585208qwb.30
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 10:17:40 -0800 (PST)
In-Reply-To: <3f574626437da8db9f7844d5bb031046@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Colin Cross <ccross@google.com>, Kukjin Kim <kgene.kim@samsung.com>, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

+ linux-omap on this thread.

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Saturday, February 12, 2011 8:40 PM
> To: Russell King - ARM Linux
> Cc: Colin Cross; Kukjin Kim; saeed bishara; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume
> support
>
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Saturday, February 12, 2011 8:20 PM
> > To: Santosh Shilimkar
> > Cc: Colin Cross; Kukjin Kim; saeed bishara; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v3 2/5] ARM: pm: add generic CPU
> suspend/resume
> > support
> >
> > On Fri, Feb 11, 2011 at 05:37:04PM +0530, Santosh Shilimkar wrote:
> > > There is a Monitor secure API, needs to be called from non-
> secure
> > > software to set this diagnostic registers in resume path.
> >
> > It would be an idea to get the OMAP sleep code up to date so that
> I
> > can
> > look at OMAPs requirements for this to be useful.
> >
> > As the current code stands, I don't see any reason why the
> sleep34xx
> > code
> > can't use this infrastructure, but I'm loathed to start modifying
> > that if there's outstanding code changes in that area.
>
> Yep. There are few issues out there with sleep34xx code.
> 	- Secure APIs
> 	- Current code needs to be cleaned up to remove
> 	unwanted registers save restore
> 	- Some part of the code on OMAP3 must be run from
> 	SRAM. It can't run from DDR
> 	- AUXCTLR, Diagnostic registers aren't accessible
> 	in secure mode.
> 	- L2 cache needs to be handled with secure APIs.
> 	- Code sequence needs to handle errata's handling
> 	which accesses OMAP PM registers.
>
> Few of the above are getting addressed for this merge window.
>
> So my plan was to take a look at generic suspend after the
> merge window. By that time your generic stuff and omap
> cleanup would have got merged hopefully.
>
> Regards,
> Santosh
