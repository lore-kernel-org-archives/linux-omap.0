From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: DSS2: Simultaneous DSI and DPI panels
Date: Thu, 12 May 2011 12:16:23 -0700
Message-ID: <BANLkTi=1XZyu6hQq7RLxcjQ0WZ8neGbNcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55301 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab1ELTQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 15:16:24 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so1561147bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 12:16:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hello,

I was wondering if it would be possible to run DPI and DSI interfaces
simultaneously with OMAP3 (DM3730).

Limitations:
- DSI would have to be in video mode (data to DSI phy through video
port with H/VSYNC signaling, OMAP_DSS_PARALLELMODE_BYPASS)
- DSI PLL would need to be used for clock source
- Both the DPI and DSI panels would have to accept identical clocking
(PCLK, blanking intervals etc).
- Data lane # must match.
- And of course same data would go to both

I realize the current SW does not support this, but I'm more wondering
if it is possible from the HW point of view because it seems to me
that data out from DISPC is pretty much identical in both cases.

 - Juha
