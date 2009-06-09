From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/4]ARM: OMAP4: SMP: Patch series
Date: Tue, 9 Jun 2009 15:19:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4EDB858@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B4BE36E4@dbde02.ent.ti.com>
 <20090608145044.GA32140@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbZFIJuF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 05:50:05 -0400
In-Reply-To: <20090608145044.GA32140@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Russell,
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Monday, June 08, 2009 8:21 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: [PATCH 0/4]ARM: OMAP4: SMP: Patch series
> 
> On Wed, May 27, 2009 at 09:52:38PM +0530, Shilimkar, Santosh wrote:
> > I have rebased this series on top of your arm-smp patches 
> and my earlier
> > basic omap4 patches.
> 
> Can you please rebase your patches on commit c7f7ff1 in my tree (it's
> in my devel branch) and I'll merge them in.
> 
> (Please don't base patches on the top of the devel branch - 
> you may notice
> it's a merge of 'devel-unstable' which is... unstable stuff.)
I have rebased my patches on commit c7f7ff1 in your tree's devel branch. The 'arch/arm/mach-types' is still not updated in your tree so I added manually to test the functionality.

Is it possible for you to pull these patches from following:

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git for_rmk

-shortlog
	Santosh Shilimkar(4)
	ARM: OMAP4: SMP: Update defconfig for OMAP4430
	ARM: OMAP4: SMP: Enable SMP support for OMAP4430
	ARM: OMAP4: SMP: Add mpu timer support for OMAP4430
	ARM: OMAP4: SMP: Add OMAP4430 SMP board files
-diffstat
 arch/arm/Kconfig                              |    8 +-
 arch/arm/configs/omap_4430sdp_defconfig       |  128 +++++++++++++-----
 arch/arm/mach-omap2/Makefile                  |    4 +
 arch/arm/mach-omap2/omap-headsmp.S            |   46 +++++++
 arch/arm/mach-omap2/omap-smp.c                |  178 +++++++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c                |    4 +
 arch/arm/mach-omap2/timer-mpu.c               |   34 +++++
 arch/arm/plat-omap/include/mach/entry-macro.S |   28 ++++
 arch/arm/plat-omap/include/mach/irqs.h        |    2 +
 arch/arm/plat-omap/include/mach/smp.h         |   51 +++++++
 10 files changed, 445 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-headsmp.S
 create mode 100644 arch/arm/mach-omap2/omap-smp.c
 create mode 100644 arch/arm/mach-omap2/timer-mpu.c
 create mode 100644 arch/arm/plat-omap/include/mach/smp.h

Regards,
Santosh
 