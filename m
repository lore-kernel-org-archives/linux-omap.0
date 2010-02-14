From: Jonas Zetterberg <jozz@jozz.se>
Subject: [PATCH 0/2] igepv2: Enable WiFi and Heartbeat LED
Date: Sun, 14 Feb 2010 20:33:23 +0100
Message-ID: <4B785003.1020002@jozz.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from proxy1.bredband.net ([195.54.101.71]:46283 "EHLO
	proxy1.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab0BNTdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Feb 2010 14:33:25 -0500
Received: from ipb2.telenor.se (195.54.127.165) by proxy1.bredband.net (7.3.140.3)
        id 4B62ECEA00A36427 for linux-omap@vger.kernel.org; Sun, 14 Feb 2010 20:33:24 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?B?RW5yaWMgQmFsbGV0YsOyIGkgU2VycmE=?= <eballetbo@iseebcn.com>, Anders Hedlund <anders.j.hedlund@gmail.com>


Some patches for the IGEPv2 board to enable WiFi and Heartbeat LED. 
Patches are completely contained within board configuration file.

Anders Hedlund (1):
   IGEPv2: Added WIFI support

Jonas Zetterberg (1):
   IGEPv2: Use Red Led1 as Heartbeat if configured

  arch/arm/mach-omap2/board-igep0020.c |   68 
+++++++++++++++++++++++++++++++++-
  1 files changed, 67 insertions(+), 1 deletions(-)

