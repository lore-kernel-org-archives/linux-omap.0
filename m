From: Xiao Jiang <jgq516@gmail.com>
Subject: Some issue about CA816x/819x EVM board
Date: Mon, 21 Mar 2011 12:45:28 +0800
Message-ID: <4D86D7E8.6010801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53088 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab1CUD7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Mar 2011 23:59:33 -0400
Received: by iyb26 with SMTP id 26so6007847iyb.19
        for <linux-omap@vger.kernel.org>; Sun, 20 Mar 2011 20:59:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I got one CA816x/819x EVM board, the board can be boot thru image which
is compiled from arago
git(http://arago-project.org/git/projects/?p=linux-omap3.git;a=summary,
and I used the tag 2.6.34_TI816XPSP_04.00.00.07),
I found some issues about the board, these issues are existed in both
arago image and the demo image.

1. SD/MMC card slot hot-plug issue
SD/MMC card slot can't support hot-plug, the SD card can only be
identify if it was pluged into slot before
system boot. After check the code of arago git, it seems the gpio part
wasn't enabled since I found the
gpio_bank_count is zero in arch/arm/plat-omap/gpio.c, I want to add gpio
bank support in the file, however
I can't find gpio base address in AM389x Sitara ARM Microprocessors
(MPUs) Technical Reference Manual.

2. SATA interface issue
SATA disk only works well if connect with SATA0/J12, the disk can't be
recognize if connect with SATA1/J11.

Does anyone has some hints for these? Thanks in advance!

Best Regards,
Xiao Jiang




