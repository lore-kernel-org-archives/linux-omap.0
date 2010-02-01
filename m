From: Ameya Palande <ameya.palande@nokia.com>
Subject: dspbridge unneeded headers
Date: Mon, 01 Feb 2010 13:08:39 +0200
Message-ID: <1265022519.6488.6.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49426 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab0BALvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 06:51:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Omar,

What is the plan for following files in bridgedriver source?

./arch/arm/plat-omap/include/dspbridge/mem.h.orig
./arch/arm/plat-omap/include/dspbridge/dbc.h.orig
./arch/arm/plat-omap/include/dspbridge/gt.h.orig
./arch/arm/plat-omap/include/dspbridge/dbg.h.orig
./drivers/dsp/bridge/wmd/ue_deh.c.orig

Can we get rid of them?

Cheers,
Ameya.

