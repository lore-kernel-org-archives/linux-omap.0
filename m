From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/1] ASoC: Added OMAP3 EVM Support
Date: Thu,  7 May 2009 21:38:30 +0530
Message-ID: <1241712510-16191-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438AbZEGQIn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2009 12:08:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, getarunks@gmail.com
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

With refernce to the discussion at:

http://marc.info/?l=linux-omap&m=124169330310075&w=2

I am resending the patch to add OMAP3 EVM support in ASoC. It
has been built/checked against the tip.

Anuj Aggarwal (1):
  ASoC: Added OMAP3 EVM support in ASoC.

 sound/soc/omap/Kconfig    |    8 +++
 sound/soc/omap/Makefile   |    2 +
 sound/soc/omap/omap3evm.c |  147 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap3evm.c

