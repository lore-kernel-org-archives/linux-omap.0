From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 0/2] twl4030-pwrbutton patches
Date: Thu, 19 Feb 2009 15:29:55 +0200
Message-ID: <1235050197-26818-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48175 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbZBSNaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 08:30:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>

Moving out of drivers/i2c/chips

Felipe Balbi (2):
  i2c: move twl4030-pwrbutton to child registration style
  twl4030: move twl4030-pwrbutton to drivers/input/misc

 drivers/i2c/chips/Kconfig                          |    4 -
 drivers/i2c/chips/Makefile                         |    1 -
 drivers/input/misc/Kconfig                         |    4 +
 drivers/input/misc/Makefile                        |    1 +
 .../{i2c/chips => input/misc}/twl4030-pwrbutton.c  |   59 +++++++++++++------
 drivers/mfd/twl4030-core.c                         |   13 ++++
 6 files changed, 58 insertions(+), 24 deletions(-)
 rename drivers/{i2c/chips => input/misc}/twl4030-pwrbutton.c (70%)

