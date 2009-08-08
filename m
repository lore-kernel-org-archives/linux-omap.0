From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH v2 0/2] Nokia n8x0 support for mainline
Date: Sat, 08 Aug 2009 12:57:08 +0300
Message-ID: <20090808095404.4829.43749.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:57411 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933758AbZHHJ5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Aug 2009 05:57:25 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 2132C8C61F
	for <linux-omap@vger.kernel.org>; Sat,  8 Aug 2009 12:57:25 +0300 (EEST)
Received: from [127.0.1.1] (YKMDCCXXIII.gprs.sl-laajakaista.fi [85.77.207.224])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id C263F27D84
	for <linux-omap@vger.kernel.org>; Sat,  8 Aug 2009 12:57:23 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here's v2 of n8x0 patches. Added proper commit logs and fixed copyright
years reported by our patch review machine Felipe Balbi :)

I hope these are now ready for mainline. These patches depend on my serial
omap tag removal patches.

---

Kalle Valo (2):
      OMAP2: n8x0: add n8x0_defconfig
      OMAP2: add board file for Nokia N800 and N810


 arch/arm/configs/n8x0_defconfig  | 1104 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig      |    4 
 arch/arm/mach-omap2/Makefile     |    2 
 arch/arm/mach-omap2/board-n8x0.c |  307 +++++++++++
 4 files changed, 1416 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/configs/n8x0_defconfig
 create mode 100644 arch/arm/mach-omap2/board-n8x0.c

