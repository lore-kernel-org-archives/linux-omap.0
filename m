From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 0/5] [RESEND] lm8323 patches
Date: Thu, 19 Feb 2009 14:29:38 +0200
Message-ID: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55979 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbZBSMaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 07:30:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <me@felipebalbi.com>

Hi Tony,

the final version is already going to mainline via linux-input,
you might wanna apply these to l-o to avoid conflicts later.

Felipe Balbi (5):
  input: lm8323: get rid of global pdata pointer
  input: lm8323: get rid of useless debug macro
  input: lm8323: general clean up
  input: lm8323: prefix led name
  input: keyboard: removed unused lm8323_set_platform_data

 arch/arm/mach-omap2/board-n800.c |   14 +++--
 drivers/input/keyboard/lm8323.c  |  113 +++++++++++++++----------------------
 include/linux/i2c/lm8323.h       |    2 -
 3 files changed, 55 insertions(+), 74 deletions(-)

