From: Mikkel Christensen <mlc@ti.com>
Subject: [PATCH 0/3] Support for OMAP3 Zoom2 board
Date: Thu,  7 May 2009 16:42:03 -0500
Message-ID: <1241732526-6218-1-git-send-email-mlc@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48948 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbZEGViZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2009 17:38:25 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n47LcKEq004885
	for <linux-omap@vger.kernel.org>; Thu, 7 May 2009 16:38:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mikkel Christensen <mlc@ti.com>

The following patch series adds support for Zoom2 board.

The board has:
 - Modem attached to UART1
 - WLAN attached to UART2
 - GPS attached to UART3

An external debug board is included for console and LAN.

For details refer to this site:
http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap34x-ii-mdp

Future work:
 - SMSC911x NFS mount problem
 - Low level debug uart need to use debug board
 - Dynamic detection of debug board presence

TI wiki with FAQs on getting this board booting:
https://omapzoom.org/gf/project/omapzoom/wiki/?pagename=GettingStartedWithZoomII_AKA_OMAP34XII_MDP
