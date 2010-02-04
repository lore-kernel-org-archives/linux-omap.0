From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 0/2] initial runtime PM layer for OMAP
Date: Wed,  3 Feb 2010 16:19:09 -0800
Message-ID: <1265242751-12199-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f201.google.com ([209.85.223.201]:63014 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758000Ab0BDATN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:19:13 -0500
Received: by iwn39 with SMTP id 39so2324202iwn.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:19:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here's a first pass implementaton at the runtime PM layer for OMAP.
As you can see, it's a pretty thin layer and the omap_device layer
does all the heavy lifting.

Following shortly to this series will be a conversion of the MMC
driver as an example of how to use the runtime PM API.

Kevin Hilman (2):
  OMAP: omap_device: add omap_device_has_lost_context()
  OMAP: PM: initial runtime PM support

 arch/arm/mach-omap2/Makefile                  |    6 ++
 arch/arm/mach-omap2/pm_runtime.c              |  119 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    3 +
 arch/arm/plat-omap/omap_device.c              |   35 +++++++
 4 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm_runtime.c

