From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/6] OMAP: hwmod: Full data set for OMAP4430 ES1.0
Date: Wed, 12 May 2010 17:54:35 +0200
Message-ID: <1273679681-27549-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43410 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab0ELPyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 11:54:45 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4CFsi27027780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 10:54:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>

Hi,

Here is the OMAP4430 ES1.0 hwmod data serie v2.
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

v1
  http://marc.info/?l=linux-omap&m=127324843814741&w=2
  
v2
  - [PATCH 3/6] OMAP4: hwmod: Enable omap_device build for OMAP4
    Removed some old defines for OMAP_32KSYNCT_BASE that has nothing
    to do in that file and was already removed by Tony.


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
 6 files changed, 4920 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_44xx_data.c

