From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/3] omap3evm: Get keypad and touchscreen working again
Date: Thu,  4 Feb 2010 14:22:03 +0530
Message-ID: <1265273523-22777-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43411 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135Ab0BDIwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 03:52:09 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o148q5Wx032476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Feb 2010 02:52:07 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This set contains patches to get the keypad and touchscreen
working after changes to new MUX framework.

The keypad macros had to be updated after migration to the
matrix_keypad as well.

Sanjeev Premi (3):
  omap3evm: Add mux settings for keypad
  omap3evm: Fixes after moving to matrix_keypad
  omap3evm: Configure GPIO175 for touchscreen PEN_IRQ

 arch/arm/mach-omap2/board-omap3evm.c |   33 +++++++++++++++++++++------------
 1 files changed, 21 insertions(+), 12 deletions(-)

