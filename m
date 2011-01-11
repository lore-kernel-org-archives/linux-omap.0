From: Ben Tucker <btucker@mpcdata.com>
Subject: OMAP DSS Enable clocks in dss_setup_partial_planes
Date: Tue, 11 Jan 2011 17:41:23 -0000
Message-ID: <c08bf1989fbe2e704960116748c416f3@mail.gmail.com>
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com
  <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com> <1294413238.3968.110.camel@nubuntu>
 <78677181845a6577fe0955a1984ac16a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41538 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1AKRl0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 12:41:26 -0500
Received: by iwn9 with SMTP id 9so20382745iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 09:41:26 -0800 (PST)
In-Reply-To: <78677181845a6577fe0955a1984ac16a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

>From 086e3454c8f154cd90a4669899f2179f16ef32cd Mon Sep 17 00:00:00 2001
From: Ben Tucker <btucker@mpc-data.co.uk>
Date: Thu, 13 Jan 2011 12:56:45 +0000
Subject: [PATCH] OMAP DSS Enable clocks in dss_setup_partial_planes
 Enable the interface clocks while calling
 configure_dispc().

---
 drivers/video/omap2/dss/manager.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c
b/drivers/video/omap2/dss/manager.c
index 545e9b9..cb90dac 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1106,7 +1106,9 @@ void dss_setup_partial_planes(struct omap_dss_device
*dssdev,
        mc->w = w;
        mc->h = h;

+       dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
        configure_dispc();
+       dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);

        mc->do_manual_update = false;

--
1.7.3.2
