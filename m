From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 00/13] OMAP4: Add modulemode support to hwmod framework
Date: Fri, 24 Jun 2011 13:05:46 +0200
Message-ID: <1308913560-333-1-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44197 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab1FXLGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 07:06:06 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is the series that finally add the management of the modulemode
directly from hwmod fmwk instead of using a fake clock node to represent
the IP.

A second series will clean most of the remaining data from the clock data
file. Before that I have to rebase Rajendra's series to control the
clockdomain from the hwmod framework, otherwise the modules will
not be enabled properly since their clockdomain will not be changed
to SW_SUP during enable.

The series is based on for_3.0.1/3_hwmod_fixes and tested
on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
are definitively needed.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.0.1/4_hwmod_modulemode

Regards,
Benoit


Benoit Cousson (13):
  OMAP4: hwmod: Add clock domain attribute
  OMAP2+: hwmod: Init clkdm field at boot time
  OMAP4: hwmod: Replace CLKCTRL absolute address with offset macros
  OMAP: hwmod: Wait the idle status to be disabled
  OMAP2+: hwmod: Replace clkdm access from main_clk using hwmod attribute
  OMAP4: hwmod: Replace RSTCTRL absolute address with offset macros
  OMAP4: prm: Replace warm reset API with the offset based version
  OMAP4: prm: Remove deprecated functions
  OMAP4: hwmod data: Align interconnect format with regular modules
  OMAP4: hwmod data: Add PRM context register offset
  OMAP4: hwmod data: Add modulemode entry in omap_hwmod structure
  OMAP4: cm: Add two new APIs for modulemode control
  OMAP4: hwmod: Introduce the module control in hwmod control

Nayak, Rajendra (1):
  OMAP2+: clockdomain: Add an api to read idle mode

 arch/arm/mach-omap2/clockdomain.c            |   21 ++
 arch/arm/mach-omap2/clockdomain.h            |    3 +
 arch/arm/mach-omap2/cm44xx.h                 |    3 +-
 arch/arm/mach-omap2/cminst44xx.c             |   84 +++++-
 arch/arm/mach-omap2/cminst44xx.h             |    8 +-
 arch/arm/mach-omap2/omap_hwmod.c             |  196 +++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  458 ++++++++++++++++++++------
 arch/arm/mach-omap2/prm44xx.c                |  145 +--------
 arch/arm/mach-omap2/prm44xx.h                |    6 -
 arch/arm/mach-omap2/prminst44xx.c            |  108 ++++++-
 arch/arm/mach-omap2/prminst44xx.h            |   10 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   14 +-
 12 files changed, 757 insertions(+), 299 deletions(-)

