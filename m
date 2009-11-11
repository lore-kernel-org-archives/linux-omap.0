From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2 0/8] introduce 3630 boards
Date: Wed, 11 Nov 2009 20:45:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A705CA2@dbde02.ent.ti.com>
References: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47219 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757479AbZKKPSL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 10:18:11 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABFIAQv005510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 09:18:16 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nABFI9ER020810
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 20:48:10 +0530 (IST)
In-Reply-To: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Wednesday, November 11, 2009 4:17 AM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [PATCH v2 0/8] introduce 3630 boards
> 
> Introducing 3630 boards: zoom3 and sdp3630
> 
> The peripherals are very similar for the two bards as per 
> this discussion:
> 	http://marc.info/?l=linux-omap&m=125676595710748&w=2
> 
> So maximum reuse is done for the board files for zoom3 and sdp3630
> 
> V1: Review comments incorporated:
> 	http://marc.info/?l=linux-omap&m=125632676504364&w=2
> 	http://marc.info/?l=linux-omap&m=125632720804869&w=2
> 	http://marc.info/?l=linux-omap&m=125633994320138&w=2
> 
> V2: Review comments by Nishanth Menon
> 	http://marc.info/?l=linux-omap&m=125728617825678&w=2
> 	http://marc.info/?l=linux-omap&m=125728665226332&w=2
> 	http://marc.info/?l=linux-omap&m=125728729027309&w=2
> 	http://marc.info/?l=linux-omap&m=125728749327603&w=2
> 

Vikram,

I'm afraid current linux-omap master + these patches does not boot
on my 3630SDP.

The bootargs used were:
mem=256M console=ttyS0,115200n8 noinitrd root=/dev/nfs rw nfsroot=172.24.162.66:/vol/vol2/swcoe_omapsw_linux1/anand/target,nolock,tcp ip=172.24.190.229:172.24.162.66:172.24.188.1:255.255.252.0:myomap::off

The image hangs after "Uncompressing kernel...... done, booting the kernel."

- Anand

> Vikram Pandita (8):
>   omap: 3630: update is_chip variable
>   omap: DEBUG_LL: allow no omap uart configuration
>   omap: zoom2: split board file for reuse
>   omap: zoom2: update defconfig
>   omap: zoom3: introduce zoom3 board support
>   omap: zoom3: defconfig creation
>   omap: 3630sdp: introduce 3630 sdp board support
>   omap: 3630sdp: defconfig creation
> 
>  arch/arm/configs/omap_3630sdp_defconfig            | 1606 ++++++++++++++++++++
>  arch/arm/configs/omap_zoom2_defconfig              |  231 ++--
>  arch/arm/configs/omap_zoom3_defconfig              | 1605 +++++++++++++++++++
>  arch/arm/mach-omap2/Kconfig                        |    8 +
>  arch/arm/mach-omap2/Makefile                       |    8 +
>  arch/arm/mach-omap2/board-3630sdp.c                |   96 ++
>  arch/arm/mach-omap2/board-zoom-peripherals.c       |  403 +++++
>  arch/arm/mach-omap2/board-zoom2.c                  |  261 +---
>  arch/arm/mach-omap2/board-zoom3.c                  |   59 +
>  arch/arm/mach-omap2/id.c                           |    2 +
>  arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   52 +
>  arch/arm/plat-omap/Kconfig                         |    3 +
>  arch/arm/plat-omap/include/plat/cpu.h              |    7 +-
>  arch/arm/plat-omap/include/plat/uncompress.h       |    4 +-
>  14 files changed, 4005 insertions(+), 340 deletions(-)
>  create mode 100644 arch/arm/configs/omap_3630sdp_defconfig
>  create mode 100644 arch/arm/configs/omap_zoom3_defconfig
>  create mode 100755 arch/arm/mach-omap2/board-3630sdp.c
>  create mode 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
>  create mode 100644 arch/arm/mach-omap2/board-zoom3.c
>  create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 