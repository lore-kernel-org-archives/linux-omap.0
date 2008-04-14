From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/2] Code update for mcbsp driver
Date: Mon, 14 Apr 2008 11:52:59 -0400
Message-ID: <1208188381-29638-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22782 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbYDNPxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 11:53:34 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3EFrJNX004041
	for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2008 18:53:31 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo <eduardo.valentin@indt.org.br>

From: Eduardo <eduardo.valentin@indt.org.br>

Hi all,

This patch series updates the mcbsp driver. It cleans up several
coding style errors and also moves code to mach- specific place.

Comments are wellcome.

Cheers,


Eduardo Valentin (2):
  PLAT-OMAP: McBSP: Coding style cleanup on arch/arm/plat-omap/mcbsp.c
  PLAT-OMAP: MCBSP: Move code mach specific from plat-omap to mach-omap

 arch/arm/mach-omap1/Makefile      |    2 +
 arch/arm/mach-omap2/Makefile      |    2 +
 arch/arm/plat-omap/mcbsp.c        |  501 ++++++++++---------------------------
 include/asm-arm/arch-omap/mcbsp.h |   19 ++
 4 files changed, 151 insertions(+), 373 deletions(-)

