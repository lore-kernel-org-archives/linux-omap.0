From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 0/7] External controller support for TWLxxxx
Date: Mon, 28 Nov 2011 16:53:18 +0200
Message-ID: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38525 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab1K1OyO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 09:54:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

Hi,

Changes compared to previous version:
- External controller support is now built in to twl-regulator.c as
  an option that gets configured during probe
- Selected controller is based on option passed in platform data,
  which also needs to be passed through twl-core.c (thus the change
  to drivers/mfd/twl-core.c)
- Dropped a couple of silly debug prints

-Tero

