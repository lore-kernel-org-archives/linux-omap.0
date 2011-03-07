From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Problem with DSS clocks & accessing registers
Date: Mon, 7 Mar 2011 10:22:29 +0200
Message-ID: <1299486149.2281.77.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43842 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839Ab1CGIWf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 03:22:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Taneja, Archit" <archit@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi Kevin, Paul,

We currently have a small problem with OMAP4 DSS. When we enable the DSS
clocks, it seems that the DSS registers are not always accessible right
after the clock enable.

I understood that on OMAP4 the clock framework doesn't guarantee that
the registers are accessible after enabling clocks, and pm_runtime will
handle this. Is this correct?

I have made a small hack fix for this. I added udelay(10) in the DSS
code which enables the clocks and this seem to remove the problem. The
delay is only called when DSS thinks the clocks have been off, so in
practice the delay shouldn't be visible. Is this fix acceptable for now,
until we get pm_runtime support to DSS? 

 Tomi


