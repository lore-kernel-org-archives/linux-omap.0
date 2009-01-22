From: Kalle Valo <kalle.valo@nokia.com>
Subject: [PATCH 0/3] Hacks to make Nokia N800 compile
Date: Thu, 22 Jan 2009 15:18:57 +0200
Message-ID: <20090122131602.18315.84862.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19501 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZAVNTy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 08:19:54 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0MDIiB7025431
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 07:19:52 -0600
Received: from [127.0.1.1] (essapo-nirac252253.europe.nokia.com [10.162.252.253])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0MDIw6S008058
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 15:18:59 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In currently linux-omap tree n800_defconfig doesn't compile because of few
compiler and linker errors. Here are the fixes/hacks which I use. I'll send 
them in case anyone else is interested them.

---

Kalle Valo (3):
      Disable linux-omap version of menelaus
      tsub6010: fix omap compile
      n800-bt: include board-nokia.h


 arch/arm/mach-omap2/board-n800-bt.c |    1 +
 drivers/i2c/chips/Makefile          |    1 -
 drivers/usb/musb/tusb6010_omap.c    |    4 ++--
 3 files changed, 3 insertions(+), 3 deletions(-)

