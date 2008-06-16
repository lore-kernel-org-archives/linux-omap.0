From: "Chandra shekhar" <x0044955@ti.com>
Subject: [RFC/PATCH  0/4] McBSP support  for 34XX
Date: Mon, 16 Jun 2008 17:50:44 +0530
Message-ID: <003a01c8cfab$67149ae0$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:42993 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609AbYFPMUx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jun 2008 08:20:53 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5GCKkxj026014
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 07:20:52 -0500
Received: from a0875540 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5GCKiTL023612
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 17:50:45 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Here is a patch that adds support for McBSP on 34XX.
It has been verified in digital loopback mode.

The patch includes the following features.

1. McBSP enabled in defconfig
2. Supporting all the LP features.
3. Support of DMA chaining mode and one time configuration for entire transfer to improve performance.
4. Independent configurations and transfer of Rx and Tx
5. MCBSP data transfer in 8, 16 and 32 bit mode.
6. instead of mcbsp client configuring all the register, it allows clients to  configure parameters like clk polarity, clk src and
other parameters.

Signed-off-by: chandra shekhar <x0044955@ti.com>

Regards
Chandra Shekhar



