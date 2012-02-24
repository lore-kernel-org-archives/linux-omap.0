From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 0/6] ARM: OMAP4 core retention support
Date: Fri, 24 Feb 2012 17:15:40 +0200
Message-ID: <1330096546-20477-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35092 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab2BXPP5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 10:15:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Changes compared to previous version:

- patch2: changed timeout value to 100us (from 1000us)
- patch2: added timeout after the WUCLKIN disable
- some cosmetic tweaking to other patches

Tested on omap4430 blaze board with EMU chip, suspend / resume ok.

-Tero

