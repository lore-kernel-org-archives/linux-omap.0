From: Vishal Mahaveer <vishalm@ti.com>
Subject: [PATCH v2 0/1] Add mmc5 and WLAN chip wl1283 chip support on blaze
Date: Fri, 24 Jun 2011 15:16:28 -0600
Message-ID: <1308950189-7357-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33858 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab1FXTsJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 15:48:09 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5OJm8il029985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:48:08 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5OJm8Zx003722
	for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:48:08 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5OJm8ob023458
	for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:48:08 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishal Mahaveer <vishalm@ti.com>


Vishal Mahaveer (1):
  omap: blaze: add mmc5/wl1283 device support

 arch/arm/mach-omap2/board-4430sdp.c |   81 +++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

