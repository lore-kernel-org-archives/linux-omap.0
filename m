From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+] ehci patches
Date: Wed, 24 Mar 2010 14:45:33 +0200
Message-ID: <1269434734-23524-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53234 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0CXMqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:46:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Hi Greg,

There's only one patch for ehci now.

Ajay Kumar Gupta (1):
  ehci: omap: fix kernel panic with rmmod

 drivers/usb/host/ehci-omap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

