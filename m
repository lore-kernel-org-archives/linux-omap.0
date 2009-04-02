From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Do early I/O mapping if spinlock debugging is
	enabled (Re: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3)
Date: Thu, 2 Apr 2009 08:38:19 +0100
Message-ID: <20090402073819.GA4337@n2100.arm.linux.org.uk>
References: <20090331184802.GA27745@n2100.arm.linux.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FB086086@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C0036E7EF891@dbde02.ent.ti.com> <alpine.DEB.2.00.0904011301320.9879@utopia.booyaka.com> <20090401220745.GJ32530@atomide.com> <87ocvghsk7.fsf@deeprootsystems.com> <20090402000055.GK32530@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56937 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbZDBHim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 03:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20090402000055.GK32530@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Juha Yrjola <juha.yrjola@solidboot.com>

On Wed, Apr 01, 2009 at 05:00:56PM -0700, Tony Lindgren wrote:
> Well turns out it's the same old bug again Juha tracked down earlier..
> 
> If CONFIG_DEBUG_SPINLOCK is set, and CONFIG_DEBUG_LL is not set, the IO
> does not get mapped. Juha's earlier patch is attached.
> 
> Russell, got any better fixes in mind for this?

No, and as I've said previously, the kernel assuming that sched_clock
is usable before stuff has been initialized is a bug plain and simple.

Your patch may fix OMAP, but it won't fix everything.

It's just not going to be possible to make this work.  spinlock debugging
needs to stop using sched_clock.
