From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: [PATCH 0/2]OMAP3 NAND: NAND support on OMAP3430
Date: Tue, 26 Aug 2008 15:39:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD517C21@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58849 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbYHZKJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 06:09:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QA9LSC028625
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 05:09:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7QA9LYw014525
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 15:39:21 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

The patches in the series are worked by Teerth Reddy <teerth@ti.com>.
This patch series adds NAND support to OMAP3430 SDP board and enable
the support for it in defconfig 'arch/arm/configs/omap_3430sdp_defconfig'.

[PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
[PATCH2/2]OMAP3 NAND: Enable support for nand driver on OMAP3430

regards,
vimal