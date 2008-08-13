From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [0/2]
Date: Tue, 12 Aug 2008 22:07:03 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A870D5F0E57@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41323 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbYHMDHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 23:07:10 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7D374Of021051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 22:07:09 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7D374eC019197
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 22:07:04 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch series fixes the omap5912 osk alsa driver.

---

 arch/arm/plat-omap/mcbsp.c        |    5 -----
 include/asm-arm/arch-omap/mcbsp.h |    8 ++++++++
 sound/arm/omap/omap-alsa-dma.c    |    2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)
