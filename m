From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: Do early I/O mapping if spinlock debugging is enabled
	(Re: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3)
Date: Wed, 1 Apr 2009 17:00:56 -0700
Message-ID: <20090402000055.GK32530@atomide.com>
References: <20090331184802.GA27745@n2100.arm.linux.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FB086086@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C0036E7EF891@dbde02.ent.ti.com> <alpine.DEB.2.00.0904011301320.9879@utopia.booyaka.com> <20090401220745.GJ32530@atomide.com> <87ocvghsk7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55232 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbZDBABK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 20:01:10 -0400
Content-Disposition: inline
In-Reply-To: <87ocvghsk7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Juha Yrjola <juha.yrjola@solidboot.com>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Kevin Hilman <khilman@deeprootsystems.com> [090401 16:18]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Paul Walmsley <paul@pwsan.com> [090401 12:04]:
> >> On Wed, 1 Apr 2009, Syed Mohammed, Khasim wrote:
> >> 
> >> > > -----Original Message-----
> >> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> >> > > Gadiyar, Anand
> >> > > Sent: Wednesday, April 01, 2009 1:55 PM
> >> > > To: Russell King - ARM Linux
> >> > > Cc: Tony Lindgren; linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> >> > > Subject: RE: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
> >> > > 
> >> > > On Wed, Apr 01, 2009 at 12:18 AM, Russell King - ARM Linux wrote:
> >> > > > On Tue, Mar 31, 2009 at 05:12:18PM +0530, Gadiyar, Anand wrote:
> >> > > > > I could not run the 3430 SDP defconfig from mainline. The image hangs at
> >> > > > > "Starting kernel ...". Enabling CONFIG_DEBUG_LL does not help.
> >> > > >
> >> > > > Did you add the necessary patch to kernel/printk.c ?
> >> > > >
> >> > > 
> >> > > Silly me, I had not done this (despite having read this so many times on this list).
> >> > > 
> >> > > Here's what I get now after adding the patch.

<snip>

> > Not seeing this on overo at least.
> >
> 
> And my Beagle is booting fine with mainline and attached .config.

<snip>

Well turns out it's the same old bug again Juha tracked down earlier..

If CONFIG_DEBUG_SPINLOCK is set, and CONFIG_DEBUG_LL is not set, the IO
does not get mapped. Juha's earlier patch is attached.

Russell, got any better fixes in mind for this?

Tony

--6sX45UoQRIJXqkqR
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="spinlock-debug.patch"

>From c699464bd92629fda1062223467588fcb0e97bca Mon Sep 17 00:00:00 2001
From: Juha Yrjola <juha.yrjola@solidboot.com>
Date: Fri, 16 Jan 2009 16:00:50 +0200
Subject: [PATCH] ARM: Do early I/O mapping if spinlock debugging is enabled

At least on OMAP, sched_clock() requires the I/O maps to be initialized.
Spinlock debugging invokes sched_clock() very early.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 21e17dc..1bc918c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -282,7 +282,7 @@ __create_page_tables:
 	.endif
 	str	r6, [r0]
 
-#ifdef CONFIG_DEBUG_LL
+#if defined(CONFIG_DEBUG_LL) || defined(CONFIG_DEBUG_SPINLOCK)
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 	/*
 	 * Map in IO space for serial debugging.

--6sX45UoQRIJXqkqR--
