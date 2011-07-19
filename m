From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [RFC 0/2 v2] join omap4panda and pcm049
Date: Tue, 19 Jul 2011 13:45:25 +0200
Message-ID: <1311075927-5562-1-git-send-email-j.weitzel@phytec.de>
References: <20110718084259.GY5783@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.visioncatalog.de ([217.6.246.34]:56304 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab1GSLpa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 07:45:30 -0400
In-Reply-To: <20110718084259.GY5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>

Try to join both boards. Only compile testet.
basis for discusson

Jan Weitzel (2):
  omap4: board-omap4panda: prepare for join
  omap4: board-omap4pcm049: add Phytec phyCORE-OMAP4

 arch/arm/mach-omap2/Kconfig                   |    6 +
 arch/arm/mach-omap2/Makefile                  |    5 +
 arch/arm/mach-omap2/board-omap4panda-common.c |  380 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap4panda-common.h |   39 +++
 arch/arm/mach-omap2/board-omap4panda.c        |  421 +++++--------------------
 arch/arm/mach-omap2/board-omap4pcm049.c       |  368 +++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h  |    1 +
 7 files changed, 875 insertions(+), 345 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap4panda-common.c
 create mode 100644 arch/arm/mach-omap2/board-omap4panda-common.h
 create mode 100644 arch/arm/mach-omap2/board-omap4pcm049.c

