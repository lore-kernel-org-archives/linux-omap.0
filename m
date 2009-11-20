From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v3 0/2] omap: serial: handle abort on empty rx fifo read
Date: Fri, 20 Nov 2009 10:02:34 -0600
Message-ID: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52467 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbZKTQCf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 11:02:35 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKG2euJ021938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 10:02:41 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

introduce OMAP3_HAS_UART_NO_EMPTY_FIFO_READ feature

this feature is set for omap3630 and omap4 currently as 
empty uart rx fifo read causes an abort

check on this feature on omap3630 and omap4 for now and extend for future
vairants in future

Patch history:
V1: initial implementation
	http://patchwork.kernel.org/patch/60785/
	http://patchwork.kernel.org/patch/60786/

V2: incorporate review comments from Alan Cox
	http://patchwork.kernel.org/patch/60785/
	to remove 8250.c file changes by override serial_in
	No 8250 driver change required now

V3: incorporate review comments
	khilman: make function override only for affected silicons
	nishant m: interoduce has_feature check, rather than cpu_is
	anand g: minor commit message change

Vikram Pandita (2):
  omap: introduce uart_no_empty_fifo_read feature
  omap: serial: fix non-empty uart fifo read abort

 arch/arm/mach-omap2/id.c              |    7 +++++++
 arch/arm/mach-omap2/serial.c          |   21 +++++++++++++++++++++
 arch/arm/plat-omap/include/plat/cpu.h |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

