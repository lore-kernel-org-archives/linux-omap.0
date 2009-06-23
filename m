From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: FW: [Help] Does HW flow contorl (auto RTS/CTS) in drivers/serial/8250.c work for OMAP34xx?
Date: Tue, 23 Jun 2009 15:18:08 +0800
Message-ID: <F12CE1A68F023D498A2691C7B5393115035EFECE@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:46087 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844AbZFWHQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 03:16:27 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n5N7GTdA027427
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 00:16:29 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n5N7GTbp020832
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 02:16:29 -0500 (CDT)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n5N7GRat020805
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 02:16:28 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

 
Instead of using below code in current drive, it seems we have to add
code to follow the steps in OMAP34xx TRM to make it work.
/*
  * TI16C752/Startech hardware flow control.  FIXME:
  * - TI16C752 requires control thresholds to be set.
  * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
  */
if (termios->c_cflag & CRTSCTS)
		efr |= UART_EFR_CTS;

Followings are copied from OMAP34xx TRM.

To enable and configure hardware flow control, perform the following
procedure:
1. Switch to register configuration mode A to access the UARTi.MCR_REG
register:
a. Save the current UARTi.LCR_REG.
b. Set UARTi.LCR_REG to 0x0080.
2. Enable register submode TCR_TLR to access UARTi.TCR_REG (part 1 of
2):
a. Save the UARTi.MCR_REG[6] TCR_TLR value.
b. Set UARTi.MCR_REG[6] TCR_TLR = 1.
3. Switch to register configuration mode B to access the UARTi.EFR_REG
register:
Set UARTi.LCR_REG to 0x00BF.
4. Enable register submode TCR_TLR to access the UARTi.TCR_REG register
(part 2 of 2):
a. Save the UARTi.EFR_REG[4] ENHANCED_EN value.
b. Set the UARTi.EFR_REG[4] ENHANCED_EN bit to 1.
5. Load the new start and halt trigger values for hardware flow control:
Set the following bits to the desired values:
* UARTi.TCR_REG[7:4] AUTO_RTS_START
* UARTi.TCR_REG[3:0] AUTO_RTS_HALT
6. Enable or disable receive and transmit hardware flow control mode and
restore the UARTi.EFR_REG[4] ENHANCED_EN value saved in Step 4a.
Set the following bits to the desired values:
* UARTi.EFR_REG[7] AUTO_CTS_EN (0: Disable/1: Enable) * UARTi.EFR_REG[6]
AUTO_RTS_EN (0: Disable/1: Enable) Restore UARTi.EFR_REG[4] ENHANCED_EN
to the saved value.
7. Switch to register configuration mode A to access UARTi.MCR_REG:
Set UARTi.LCR_REG to 0x0080.
8. Restore the UARTi.MCR_REG[6] TCR_TLR value saved in Step 2a.
9. Restore the UARTi.LCR_REG value saved in Step 1a.
See Section 17.4.4.1.3.2, Hardware Flow Control, to choose the following
values:
* UARTi.EFR_REG[7] AUTO_CTS_EN
* UARTi.EFR_REG[6] AUTO_RTS_EN
* UARTi.TCR_REG[7:4] AUTO_RTS_START
* UARTi.TCR_REG[3:0] AUTO_RTS_HALT
