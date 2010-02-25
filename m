From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC][PATCH 0/3] OMAP3630: UART4 startup
Date: Thu, 25 Feb 2010 08:41:13 -0600
Message-ID: <1267108876-18028-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762Ab0BYOlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 09:41:09 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1PEf9RU005689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 08:41:09 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

Hi,

This small RFC patchlist is intending to add initial UART4 support
for omap36xx chips.

VERY IMPORTANT:
 - This is currently untested. I don't have the HW to test this.
 - I don't consider myself an omap-serial expert, so please review
   carefully.

Regards,
Sergio

Detailed changeset:

Sergio Aguirre (3):
  ARM: OMAP3630: PRCM: Add UART4 control bits
  OMAP clock: Add uart4_ick/fck definitions for 3630
  omap3: serial: Add uart4 wakeup handling

 arch/arm/mach-omap2/clock34xx_data.c |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h    |    4 ++++
 arch/arm/mach-omap2/serial.c         |    4 ++++
 3 files changed, 30 insertions(+), 0 deletions(-)

