From: srinath@mistralsolutions.com
Subject: [Added craneboard support 0/1]
Date: Fri, 15 Oct 2010 15:57:11 +0530
Message-ID: <1287138432-23880-1-git-send-email-srinath@mistralsolutions.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64376 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0JOKqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 06:46:46 -0400
Received: by iwn35 with SMTP id 35so777221iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Oct 2010 03:46:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, jdk@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com, Srinath <srinath@mistralsolutions.com>

From: Srinath <srinath@mistralsolutions.com>

This series adds support for the AM3517/05 based craneboard. We are a team of
engineers working at Mistral Solutions and will be sending patches to support 
this board. Request you to review and accept these patches.

Added board file for AM3517/05 craneboard

Srinath (1):
  Added-craneboard-basic-support

 arch/arm/configs/omap2plus_defconfig    |    1 +
 arch/arm/mach-omap2/Kconfig             |    6 +++
 arch/arm/mach-omap2/Makefile            |    2 +
 arch/arm/mach-omap2/board-am3517crane.c |   68 +++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am3517crane.c

