From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 0/2] OMAP: Flash device support 3630 sdp board
Date: Tue,  6 Apr 2010 17:59:08 +0530
Message-ID: <1270556950-32336-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256Ab0DFM3O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Apr 2010 08:29:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o36CTB5b014538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 07:29:13 -0500
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

Sukumar Ghorai (2):
  OMAP3630SDP: Add support for Flash
  OMAP3630SDP: enable Flash device support

 arch/arm/mach-omap2/Makefile          |    1 +
 arch/arm/mach-omap2/board-3630sdp.c   |  111 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-sdp-flash.c |    2 +
 arch/arm/configs/omap_3630sdp_defconfig |   77 ++++++++++++++++++++++++++++++-


