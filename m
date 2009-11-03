From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 0/8] RFC: introduce 3630 boards
Date: Wed, 4 Nov 2009 02:53:34 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA42EC7F@dbde02.ent.ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50223 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbZKCVXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 16:23:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3LNgVN009533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 15:23:44 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3LNgtu010076
	for <linux-omap@vger.kernel.org>; Wed, 4 Nov 2009 02:53:42 +0530 (IST)
In-Reply-To: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Pandita, Vikram
>Sent: Tuesday, November 03, 2009 3:20 PM
>To: linux-omap@vger.kernel.org
>Cc: Pandita, Vikram
>Subject: [PATCH 0/8] RFC: introduce 3630 boards
>
>Introducing 3630 boards: zoom3 and sdp3630

These patches are in my git tree at: 
git://dev.omapzoom.org/pub/scm/integration/kernel-omap3.git zoom3

this is to help ease cloning in case required.

>
>The peripherals are very similar for the two bards as per this discussion:
>http://marc.info/?l=linux-omap&m=125676595710748&w=2
>
>So maximum reuse is done for the board files for zoom3 and sdp3630
>
>Review comments incorporated:
>http://marc.info/?l=linux-omap&m=125632676504364&w=2
>http://marc.info/?l=linux-omap&m=125632720804869&w=2
>http://marc.info/?l=linux-omap&m=125633994320138&w=2
>
>Vikram Pandita (8):
>  omap: 3630: update is_chip variable
>  omap: DEBUG_LL: allow no omap uart configuration
>  omap: zoom2: split baord file for reuse
>  omap: zoom2: update defconfig
>  omap: zoom3: introduce zoom3 board support
>  omap: zoom3: defconfig creation
>  omap: 3630sdp: introduce 3630 sdp board support
>  omap: 3630sdp: defconfig creation
>
> arch/arm/configs/omap_3630sdp_defconfig            | 1606 ++++++++++++++++++++
> arch/arm/configs/omap_zoom2_defconfig              |  231 ++--
> arch/arm/configs/omap_zoom3_defconfig              | 1605 +++++++++++++++++++
> arch/arm/mach-omap2/Kconfig                        |    8 +
> arch/arm/mach-omap2/Makefile                       |    8 +
> arch/arm/mach-omap2/board-3630sdp.c                |   96 ++
> arch/arm/mach-omap2/board-zoom-peripherals.c       |  414 +++++
> arch/arm/mach-omap2/board-zoom2.c                  |  261 +---
> arch/arm/mach-omap2/board-zoom3.c                  |   59 +
> arch/arm/mach-omap2/id.c                           |    2 +
> arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   54 +
> arch/arm/plat-omap/Kconfig                         |    3 +
> arch/arm/plat-omap/include/plat/cpu.h              |    7 +-
> arch/arm/plat-omap/include/plat/uncompress.h       |    4 +-
> 14 files changed, 4018 insertions(+), 340 deletions(-)
> create mode 100644 arch/arm/configs/omap_3630sdp_defconfig
> create mode 100644 arch/arm/configs/omap_zoom3_defconfig
> create mode 100755 arch/arm/mach-omap2/board-3630sdp.c
> create mode 100755 arch/arm/mach-omap2/board-zoom-peripherals.c
> mode change 100644 => 100755 arch/arm/mach-omap2/board-zoom2.c
> create mode 100755 arch/arm/mach-omap2/board-zoom3.c
> create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h

