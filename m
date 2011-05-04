From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: [Q] USB OTG host
Date: Wed, 04 May 2011 16:03:08 +0200
Message-ID: <1304517788.17252.16.camel@lws-weitzel>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phycore.de ([217.6.246.34]:35792 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab1EDODK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 10:03:10 -0400
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id 7A716A30A1
	for <linux-omap@vger.kernel.org>; Wed,  4 May 2011 16:05:30 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,
I am using drivers/usb/musb/omap2430.c for a board configured in
MUSB_OTG mode.
Is it correct that I need to load gadget driver to get it working as
host? 
I got an USB_EVENT_ID event, but in musb_otg_notifications vbus will not
switched on if !musb->gadget_driver.
Any ideas?
Kind regards,
Jan Weitzel 

