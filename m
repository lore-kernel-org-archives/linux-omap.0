From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC 0/5] OMAP4: mux: Add the OMAP4430 ES1 support
Date: Fri, 24 Sep 2010 11:15:43 +0200
Message-ID: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45403 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213Ab0IXJPv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 05:15:51 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8O9FpvM022244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 04:15:51 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o8O9Fo0J023281
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 04:15:50 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8O9FouY000774
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 04:15:50 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>


Hi,

Upon popular request, here is the series that apparently some people were
expected for some time :-) 

Only ES1 is supported for the moment, ES2 will come soon (if not today, probably on Monday).
95% of the mux is similar but due to the replacement of some IP (unipro),
we do have a couple of differences.
  
I have added the complete mux dump in sdp4430 board file, just as a starting point,
in order to start getting rid of the X-loader mux settings.
For the moment I2C device init is the only user of the omap_mux_init_signal,
at least on OMAP4. 
That removed the warning we have at the moment:
    mux: Could not set signal i2c2_scl
    mux: Could not set signal i2c2_sda
    mux: Could not set signal i2c3_scl
    mux: Could not set signal i2c3_sda
    mux: Could not set signal i2c4_scl
    mux: Could not set signal i2c4_sda

I hope that for long term, driver guys will move that to the proper device init file.

I removed as well the access to low level functions, because even if this
is needed by some driver (TBC), I don't think it is safe to expose such
low level accessor. We should probably add something for driver that
need to dynamically modify the mux settings at runtime. For example, 
we can keep the mux data for pins that might be modified later, like
you did for GPIOs.

I tested it on OMAP4430 PAB & SDP and Santosh did some test with omap3_defconfig on
OMAP3430 and OMAP4430 SDP.

patches are based on mainline 2.6.36-rc5 and located here:
git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4

Regards,
Benoit


Benoit Cousson (5):
  OMAP: mux: Add support for control module split in several partitions
  OMAP: mux: Make low level function private
  OMAP4: mux: Add data for OMAP4430 ES1
  OMAP4: mux: Select CBL package for SDP4430 with ES1
  OMAP4: mux: Temporary initial SDP4430 mux settings

 arch/arm/mach-omap2/Kconfig         |    4 +
 arch/arm/mach-omap2/Makefile        |    1 +
 arch/arm/mach-omap2/board-4430sdp.c |  389 ++++++++++++++
 arch/arm/mach-omap2/mux.c           |  133 ++++--
 arch/arm/mach-omap2/mux.h           |   67 ++-
 arch/arm/mach-omap2/mux2420.c       |   22 +-
 arch/arm/mach-omap2/mux2430.c       |   22 +-
 arch/arm/mach-omap2/mux34xx.c       |   18 +-
 arch/arm/mach-omap2/mux44xx.c       |  944 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux44xx.h       |  278 ++++++++++
 10 files changed, 1791 insertions(+), 87 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mux44xx.c
 create mode 100644 arch/arm/mach-omap2/mux44xx.h

