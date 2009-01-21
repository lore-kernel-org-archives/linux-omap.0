From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] TWL: USB: disable VUSB regulators
Date: Wed, 21 Jan 2009 15:15:17 +0200
Message-ID: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sink.edelkey.net ([213.138.147.137]:56683 "EHLO
	sink.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbZAUNPc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 08:15:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net

The TWL5030/4030 internal VUSB regulators are eating current
like small piggies. The following patch makes an aptempt at
making the twl4030-usb consumer driver dynamically disable
and enable the regulators it needs.

This regulator fw stuff is fairly new so any comments are
appreciated.

Tested on custom omap3430 hw. Build tested on beagle and
SDP defconfigs. If anyone could test this on public hw, that
would be great. There should be a noticeable drop in power
consumption when usb cable is unplugged with this patch. 


Kalle Jokiniemi (1):
      TWL: USB: disable VUSB regulators when cable unplugged



