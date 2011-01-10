From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 0/3] IGEP board changes for .38 merge window
Date: Mon, 10 Jan 2011 14:26:11 +0100
Message-ID: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54847 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab1AJN0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 08:26:25 -0500
Received: by wwi17 with SMTP id 17so1607503wwi.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 05:26:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Hi Tony,

Here's a new patches for IGEP boards. These patches are rebased on top of your 
for-next tree. Please consider adding for .38 merge window. Thanks.

Cheers,

Enric Balletbo i Serra (3):
  omap3: igep3: Add USB EHCI support for IGEP module.
  omap3: igep3: Fix IGEP module second MMC channel power supply.
  omap3: igep2: Add keypad support.

 arch/arm/mach-omap2/board-igep0020.c |   33 ++++++++++++++
 arch/arm/mach-omap2/board-igep0030.c |   80 +++++++++++++++++++++++++++++-----
 2 files changed, 102 insertions(+), 11 deletions(-)

