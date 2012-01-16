From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] ARM: OMAP3: fix build on !CONFIG_IOMMU_API
Date: Mon, 16 Jan 2012 12:03:32 +0100
Message-ID: <20120116110332.GB19394@amd.com>
References: <1326288491-25146-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:33679
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754086Ab2APLDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 06:03:44 -0500
Content-Disposition: inline
In-Reply-To: <1326288491-25146-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Arik Nemtsov <arik@wizery.com>, Raja Govindraj <govindraj.raja@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Jan 11, 2012 at 03:28:11PM +0200, Ohad Ben-Cohen wrote:
> omap3isp depends on CONFIG_IOMMU_API, so avoid registering its
> device (and defining its configuration structs) on !CONFIG_IOMMU_API.
> 
> This is generally nice to have, but more importantly, it fixes:
> 
> arch/arm/plat-omap/include/plat/iommu.h: In function 'dev_to_omap_iommu':
> arch/arm/plat-omap/include/plat/iommu.h:135: error: 'struct
> dev_archdata' has no member named 'iommu'
> arch/arm/mach-omap2/devices.c: In function 'omap3_init_camera':
> arch/arm/mach-omap2/devices.c:222: error: 'struct dev_archdata' has no
> member named 'iommu'
> make[1]: *** [arch/arm/mach-omap2/devices.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Which happens because while setting up the omap3isp device we try
> to access the (now nonexistent) iommu member of dev_archdata.
> 
> Compile tested with omap2plus_defconfig on today's:

Applied. Will send pull-request soon.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

