From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v2 0/0] McBSP changes for OMAP4 platform
Date: Wed,  5 May 2010 20:15:44 -0500
Message-ID: <1273108546-2507-1-git-send-email-jorge.candelaria@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59852 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab0EFB0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 21:26:37 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o461Qaim028176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 May 2010 20:26:36 -0500
Received: from emcc1.sasken-mty.naucm.ext.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o461QZY7026042
	for <linux-omap@vger.kernel.org>; Wed, 5 May 2010 20:26:36 -0500 (CDT)
Received: from localhost.localdomain (x0107209-ubuntu.sasken-mty.naucm.ext.ti.com [10.87.231.217])
	by emcc1.sasken-mty.naucm.ext.ti.com (8.13.8+Sun/8.13.8) with ESMTP id o461QZVX018668
	for <linux-omap@vger.kernel.org>; Wed, 5 May 2010 20:26:35 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The following patches enable McBSP driver to be used along with the
audio driver in SDP4430 and other OMAP4 based boards.

Changes from v1:
- Changed to correct IRQ lines.
- Check if rx_irq is defined, instead of checking if cpu is omap4

Jorge Eduardo Candelaria (2):
      ARM: McBSP: Fix request for irq in OMAP4
      ARM: OMAP4: Add support for omap4 in McBSP driver

 arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
 arch/arm/plat-omap/mcbsp.c  |   34 +++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 23 deletions(-)

