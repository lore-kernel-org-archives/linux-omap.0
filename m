From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/2] musb patches
Date: Wed, 11 Jun 2008 14:07:10 +0300
Message-ID: <1213182432-23952-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21622 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbYFKLI1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 07:08:27 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5BB8AcY022327
	for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 14:08:24 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Hi Tony, all

I have this two patches for musb before we merge it
upstream.

The first one makes MUSB_OTG depending on PM
otherwise we have a cyclic dependency and the
second one get back on ignoring disconnect
interrupt because I noticed that tusb2.0
gets broken after a power cycle without this
"check"

Felipe Balbi (2):
  usb: musb: MUSB_OTG should depend on PM
  usb: musb: ignore disconnect on suspend

 drivers/usb/musb/Kconfig     |    3 +--
 drivers/usb/musb/musb_core.c |    6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

