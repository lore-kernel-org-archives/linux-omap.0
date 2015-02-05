From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] MUSB fix for disabled multipoint and generic phy
Date: Thu,  5 Feb 2015 08:35:11 -0800
Message-ID: <1423154113-23463-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.ore.mailhop.org ([54.149.35.133]:47748 "EHLO
	smtp6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967063AbbBEQiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 11:38:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

Here are two fixes, the first one probably should be Cc stable.

Regards,

Tony


Tony Lindgren (2):
  usb: musb: Fix use for of_property_read_bool for disabled multipoint
  usb: musb: Fix getting a generic phy for musb_dsps

 drivers/usb/musb/musb_dsps.c | 24 ++++++++++++++++++++++--
 drivers/usb/musb/omap2430.c  |  7 +++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.1.4

