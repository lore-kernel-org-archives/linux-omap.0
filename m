From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Add clockdomain and hwmod data needed to boot dm816x
Date: Tue, 13 Jan 2015 15:22:33 -0800
Message-ID: <1421191355-12835-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52214 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbbAMX0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:26:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

These patches add the basic data needed for booting dm816x
after the fixes I posted earlier today. Note that also the
device tree related changes are needed that will be posted
in another series.

Regards,

Tony


Aida Mynzhasova (1):
  ARM: OMAP2+: Add clock domain support for dm816x

Tony Lindgren (1):
  ARM: OMAP2+: Add dm816x hwmod support

 arch/arm/mach-omap2/Makefile                |    3 +
 arch/arm/mach-omap2/clockdomain.h           |    1 +
 arch/arm/mach-omap2/clockdomains81xx_data.c |  191 +++++
 arch/arm/mach-omap2/cm81xx.h                |   61 ++
 arch/arm/mach-omap2/io.c                    |   12 +-
 arch/arm/mach-omap2/omap_hwmod.c            |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h            |    1 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 1025 +++++++++++++++++++++++++++
 8 files changed, 1291 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm81xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_81xx_data.c

-- 
2.1.4

