From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git+ 0/5] twl4030 GPIO updates
Date: Mon, 13 Oct 2008 12:59:50 -0700
Message-ID: <200810131259.50460.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:36220 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752827AbYJMUSg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Oct 2008 16:18:36 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Following this are several patches making the twl4030 GPIO code
fit better into the GPIO framework, updating its only current
user (hsmmc glue) and adding one more (Beagle).

 - gpio_request()/gpio_free() hook, now in MM for 2.6.28-rc merge
 - use that mechanism for twl4040 GPIOs
 - remove most twl-specific calls from mach-omap2/hsmmc.c glue
 - support LEDA and LEDB as output-only GPIOs
 - support those two LED signals on Beagle (one is a real LED!)

This goes on top of the preceding patches to update IRQ handling
for the twl core.

Capsule summary:  the only remaining twl40-specific GPIO calls
are to enable hardware debouncing, with potential upstream generic
support soon; and disabled linkages of the MMC power supplies to
those card detect lines (best suited IMO to platform_data, once
it's tested).

Which makes twl4030-gpio nearly ready to go upstream.
