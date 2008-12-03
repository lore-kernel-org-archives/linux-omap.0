From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 0/2] legacy gpio phaseout (V) ...
Date: Wed,  3 Dec 2008 09:37:22 +0200
Message-ID: <1228289844-5897-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46984 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbYLCHhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 02:37:47 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB37bSvS005288
	for <linux-omap@vger.kernel.org>; Wed, 3 Dec 2008 09:37:44 +0200
Received: from localhost.localdomain (esdhcp042162.research.nokia.com [172.21.42.162])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mB37bZDN030532
	for <linux-omap@vger.kernel.org>; Wed, 3 Dec 2008 09:37:35 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

With these two patches gpiolib conversion in mainline is almost complete when
applied on top of Tony's Omap gpio update set for 2.6.29. Only board-apollon.c
is remain in mainline but it is differentiated quite much from linux-omap so
I'm going to send my next set against linux-omap only.

Note, these versions don't change mach/gpio.h include statement to
linux/gpio.h due merge conflicts in mainline. SX1 seems to lack some
gpio-swich related patch and omap2 onenand is getting some include fixes
from mtd tree.


-- 
Jarkko
