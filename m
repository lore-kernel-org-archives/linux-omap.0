From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH 0/0] McBSP changes for OMAP4 platform
Date: Tue,  4 May 2010 18:37:48 -0500
Message-ID: <1273016270-31452-1-git-send-email-jorge.candelaria@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34152 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab0EDXsf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 19:48:35 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o44NmX3w028481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 4 May 2010 18:48:33 -0500
Received: from emcc1.sasken-mty.naucm.ext.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o44NmWVY012267
	for <linux-omap@vger.kernel.org>; Tue, 4 May 2010 18:48:32 -0500 (CDT)
Received: from localhost.localdomain (x0107209-ubuntu.sasken-mty.naucm.ext.ti.com [10.87.231.217])
	by emcc1.sasken-mty.naucm.ext.ti.com (8.13.8+Sun/8.13.8) with ESMTP id o44NmVd9018566
	for <linux-omap@vger.kernel.org>; Tue, 4 May 2010 18:48:31 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The following patches enable McBSP driver to be used along with the
audio driver in SDP4430 and other OMAP4 based boards.

Jorge Eduardo Candelaria (2):
      ARM: McBSP: Fix request for irq in OMAP4
      ARM: OMAP4: Add support for omap4 in McBSP driver

 arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
 arch/arm/plat-omap/mcbsp.c  |   34 +++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 23 deletions(-)

