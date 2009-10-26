From: "Pais, Allen" <allen.pais@ti.com>
Subject: [PATCH 0/2] Introduce 3630sdp board file.
Date: Mon, 26 Oct 2009 13:12:57 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765AbZJZHiT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 03:38:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9Q7cLjt020682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 02:38:23 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9Q7cKET015105
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 13:08:20 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

OMAP3630 is a migration in GS70 process of the OMAP3430 with some performance improvements. OMAP3630 is a high performance multimedia application processor based on the enhanced OMAP 3 Architecture integrated on a 45nm process

OMAP3630's architecture is designed for 2.5G wireless terminals, 3G wireless terminals, rich multi-media featured handsets and high performance PDAs to provide best-in-class video, image and graphics processing sufficient to support:
	Streaming video,
	2D/3D mobile gaming,
	Video conferencing,
	High resolution still image,
	Video capture.

arch/arm/mach-omap2/board-3630sdp.c |  188 +++++++++++++ 
arch/arm/mach-omap2/Kconfig         |    4 ++++  
arch/arm/mach-omap2/Makefile        |    1 + ++++++++++++++++++++++  