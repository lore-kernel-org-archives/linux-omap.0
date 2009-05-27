From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4]ARM: OMAP4: SMP: Patch series
Date: Wed, 27 May 2009 10:15:48 -0700
Message-ID: <20090527171548.GC6267@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B4BE36E4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60669 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919AbZE0RQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 13:16:02 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B4BE36E4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090527 09:22]:
> Russell,
> I have rebased this series on top of your arm-smp patches and my earlier basic omap4 patches.
> Series is based of kernel.org 2.6.30-rc6 ( commit:1406de8e11eb043681297adf86d6892ff8efc27a). This series have dependency on [1],[2],[3],[4] and latest mach-types
> 
> The series contains:
> 	[PATCH 1/4] ARM: OMAP4: SMP: Add OMAP4430 SMP board files
> 	[PATCH 2/4] ARM: OMAP4: SMP: Add mpu timer support for OMAP4430
> 	[PATCH 3/4] ARM: OMAP4: SMP: Enable SMP support for OMAP4430
> 	[PATCH 4/4] ARM: OMAP4: SMP: Update defconfig for OMAP4430
> 
> Regards,
> Santosh
> 
> [1]:	Russell's arm-smp patch series + one of my patch
> 	http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/arm:smp.diff
> 
> [2]:	Tony's : [PATCH 0/5] More header clean-up
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12231.html
> 
> [3]:	Mine [PATCH 0/4] OMAP: Cleanup series.
> 	http://lists.arm.linux.org.uk/lurker/message/20090519.131647.c2c471ef.en.html
> 	
> [4]:	Mine [PATCH 0/4] ARM: OMPA4: Basic boot patch series based on linux-omap
> 	http://lists.arm.linux.org.uk/lurker/message/20090520.125900.9209eb81.en.html

Just to summarize, I have pretty much things ready for Russell to merge 
for all the posted omap stuff. That includes sets 2 + 3 + 4 above, but
not this series. That should remove any remaining merge dependencies
for this series.

Tony
