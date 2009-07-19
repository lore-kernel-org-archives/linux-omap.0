From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH v2] OMAP3: PM: USBHOST: clear wakeup events on both hosts
Date: Sun, 19 Jul 2009 08:39:49 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039681E5E2@dlee02.ent.ti.com>
References: <1247877189-5754-1-git-send-email-vikram.pandita@ti.com>
 <13B9B4C6EF24D648824FF11BE8967162039681E5E1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37897 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280AbZGSNj5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 09:39:57 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039681E5E1@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> So point is... for USB having this WKST status bit set and NOT having the F-
> Clk enabled points to an issue in the OFF mode transition code in the USB
> driver.

Or if this is on 1st boot, then issue can be init code needing to clean up whatever damage the boot loader may have done. Prcm_init should really have done this as you don't always have a controlling USB driver.

Regards,
Richard W.

