From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: omap nand driver problem with beagle board
Date: Sun, 30 May 2010 11:54:03 +0200
Message-ID: <4C0235BB.8020408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33392 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0E3J43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 May 2010 05:56:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: Linux Embedded <linux-embedded@vger.kernel.org>

Hi,

I'm using the kernel 2.6.34 with beagle board rev. c4. The omap nand
driver fails the probe because the field phys_base in the
omap_nand_platform_data struct is never set in the board specific code.
Indeed, the driver fails because the read address is 0x0. Is it a
regression? Has someone the same problem? What is phys address of nand
in this board to fix the problem?

Thanks.

Regards,

Marco
