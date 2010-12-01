From: Rick Bronson <rick@efn.org>
Subject: UART RX wakeup from sleep not working
Date: Wed, 01 Dec 2010 07:53:06 -0800
Message-ID: <E1PNozS-00020z-OZ@amazonia.comcast.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:51178 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab0LAPxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 10:53:08 -0500
Received: from amazonia.comcast.net (c-67-171-240-38.hsd1.or.comcast.net [67.171.240.38])
	by samwise.efn.org (Postfix) with ESMTP id 367F4170043
	for <linux-omap@vger.kernel.org>; Wed,  1 Dec 2010 07:53:08 -0800 (PST)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1PNozS-00020z-OZ
	for linux-omap@vger.kernel.org; Wed, 01 Dec 2010 07:53:06 -0800
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

  I'm having trouble getting the UART wakeup from sleep via activity
on the RX pin working.

--------------------------------------------------------
Assumptions (using UART3)

1. Using Arago Linux 2.6.32
2. OMAP3730 is in sleep mode via
   echo 1 > /mnt/dbg/pm_debug/sleep_while_idle
3. The UARTi.SCR_REG[4] RX_CTS_WU_EN bit is set to 1.
4. The UARTi.IER_REG[4] SLEEP_MODE bit to 1
5. The UARTi.SYSC_REG[2] ENAWAKEUP bit is set to 1
6. The UARTi.WER_REG EVENT_4_RX_ACTIVITY bit is set to 1
7. The UARTi.SSR_REG RX_CTS_DSR_WAKE_UP_STS bit is set to 1

Expectations

  When a character arrives on the RX pin of UART3 when in sleep mode,
the OMAP3730 exits sleep mode immediately via a RX_CTS_DSR_WAKE_UP
interrupt.

Problem

  The interrupt does happen but only after the UART clocks have been
enabled.  The OMAP3730 seems to exit sleep mode only when the UART
clocks are re-enabled via omap_uart_enable_clocks() in
arch/arm/mach-omap2/serial.c
--------------------------------------------------------

  Any help greatly appreciated.

  Rick
