From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest additional build warnings
Date: Sat, 9 Feb 2013 11:49:18 +0000
Message-ID: <20130209114918.GJ17852@n2100.arm.linux.org.uk>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39211 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab3BILts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 06:49:48 -0500
Content-Disposition: inline
In-Reply-To: <20130205142218.GB17833@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, Feb 05, 2013 at 02:22:18PM +0000, Russell King - ARM Linux wrote:
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used

I'm still seeing the above in the build of Friday's merge.  I'm also
seeing additional warnings in the randconfig similar to the above for
arch/arm/mach-omap2/omap-iommu.c.
