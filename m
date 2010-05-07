From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/6] OMAP: hwmod: Full data set for OMAP4430 ES1.0
Date: Fri,  7 May 2010 18:06:58 +0200
Message-ID: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53907 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974Ab0EGQHI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 12:07:08 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o47G778w004965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 7 May 2010 11:07:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>

Hi,

Here is the OMAP4430 ES1.0 hwmod data serie.
It is based on the "OMAP: HWMOD fixes and cleanup serie":
  http://marc.info/?l=linux-omap&m=127324706012621&w=2

It was only tested on OMAP4430 ES1.0 GP device using PAB board for the moment.

Please note, that the two temporary fixes are pure hacks that are just there
to allow the OMAP4 hwmod to boot properly and work corretly with the debug
uart. There are not intented to go upstream.

The second part of the data set "OMAP4: hwmod: Add remaining hwmod support 
for OMAP4430 ES1.0" is commented out for the moment. 
The idea being that each time a driver is validated with this hwmod data,
the comment can (and must) be removed.

I'd like to thanks Rajendra and Santosh for their help during the debug.

Comments are welcome.

Thanks,
Benoit


Benoit Cousson (3):
  OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0
  OMAP4: hwmod: Enable omap_hwmod build for OMAP4
  OMAP4: hwmod: Add remaining hwmod support for OMAP4430 ES1.0

Rajendra Nayak (3):
  OMAP4: hwmod: Enable omap_device build for OMAP4
  OMAP: hwmod: Temporary disable dependency
  OMAP: hwmod: Temp fixes to get hwmod registers work

 arch/arm/mach-omap2/Makefile                 |    3 +-
 arch/arm/mach-omap2/io.c                     |    6 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   12 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   | 4900 ++++++++++++++++++++++++++
 arch/arm/plat-omap/Makefile                  |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 arch/arm/plat-omap/omap_device.c             |   12 +
 7 files changed, 4932 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_44xx_data.c

