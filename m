From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH 0/2] Nokia n8x0 support for mainline
Date: Fri, 07 Aug 2009 16:06:05 +0300
Message-ID: <20090807130416.4978.96828.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52255 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbZHGNGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 09:06:07 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 650E418D955
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 16:06:06 +0300 (EEST)
Received: from [127.0.1.1] (a91-155-131-184.elisa-laajakaista.fi [91.155.131.184])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 5B2A341BE6
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 16:06:05 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here are patches for mainline to support Nokia N800 and N810. Tested on 
Nokia N800. Lots of stuff still missing, but we have to start from
somewhere.

---

Kalle Valo (2):
      n8x0: add n8x0_defconfig
      Add support for Nokia N800


 arch/arm/configs/n8x0_defconfig  | 1104 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig      |    4 
 arch/arm/mach-omap2/Makefile     |    2 
 arch/arm/mach-omap2/board-n8x0.c |  307 +++++++++++
 4 files changed, 1416 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/configs/n8x0_defconfig
 create mode 100644 arch/arm/mach-omap2/board-n8x0.c

