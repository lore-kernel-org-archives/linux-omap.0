From: "Girish. S. G." <girishsg@ti.com>
Subject: [RFC][PATCH 0/1] serial: OMAP driver
Date: Thu, 31 Jul 2008 16:53:05 +0530 (IST)
Message-ID: <44480.192.168.10.88.1217503385.squirrel@dbdmail.itg.ti.com>
Reply-To: girishsg@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:55288 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbYGaLXM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jul 2008 07:23:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi Tony,
This patch brings in serial driver for OMAP uart. This patch is taken from
earlier attempts of having serial driver specific for OMAP.
Tested on 3430. Any issues please report.

This Patch:
1. Adds support serial/debug uart
2. Fixes some of the bugs.

TODO:(These features will be added eventually)
1. Add PM realted changes specific to OMAP UART
2. Add high speed non-dma support.(Oversampling 13x mode)
3. Add dma support.

Regards,
Girish

