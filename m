From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 0/2] OMAP3430SDP: Fix checkpatch.pl warnings
Date: Wed, 25 Feb 2009 16:02:34 -0600
Message-ID: <A24693684029E5489D1D202277BE89442DF83999@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60429 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075AbZBYWCm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 17:02:42 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1PM2Zeu023857
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:02:40 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1PM2Zff008821
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:02:35 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>

>From bd4df7db454add3f679456a1e7f4c814f297cc71 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Wed, 25 Feb 2009 16:01:04 -0600
Subject: [PATCH 0/2] OMAP3430SDP: Fix checkpatch.pl warnings

This 2 small patches fixes 3 warnings seen when running
checkpatch.pl script on latest 3430sdp boardfile.

Sergio Aguirre (2):
  OMAP3430SDP: Remove unneded extern line
  OMAP3430SDP: Get rid of checkpatch.pl warnings with includes

 arch/arm/mach-omap2/board-3430sdp.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

