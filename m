From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [RFC][PATCH 0/3] OMAP PM: Voltage layer clean up
Date: Tue, 15 Mar 2011 20:03:39 +0530
Message-ID: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757281Ab1COO37 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 10:29:59 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2FETuh0023030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 09:29:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

This patch series attempts to do some more clean up on OMAP Voltage layer on top
of the clean up done by Paul as part of
https://patchwork.kernel.org/patch/591421/

These patches are generated against latest omap-for-linus branch on Tony's tree
(commit id: 05f689400ea5fa3d71af82f910c8b140f87ad1f3) and tested on OMAP ZOOM3
and OMAP4430 SDP with Smartreflex enabled.

Vishwanath BS (3):
  OMAP PM: Seggregate Voltage layer parameters
  OMAP PM: Add support for bypassing VP/VC in Voltage layer
  OMAP PM: Add Board specific parameters for OMAP Volatge layer

 arch/arm/mach-omap2/board-4430sdp.c           |   52 +++++++
 arch/arm/mach-omap2/board-zoom.c              |   79 +++++++++++
 arch/arm/mach-omap2/omap_opp_data.h           |    8 +
 arch/arm/mach-omap2/omap_twl.c                |  113 ++++++++--------
 arch/arm/mach-omap2/opp3xxx_data.c            |   50 +++++++
 arch/arm/mach-omap2/opp4xxx_data.c            |   38 +++++
 arch/arm/mach-omap2/voltage.c                 |  179 ++++++++++++++++++++-----
 arch/arm/mach-omap2/voltage.h                 |  119 +++++++++++++++--
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    4 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    4 +
 10 files changed, 541 insertions(+), 105 deletions(-)

