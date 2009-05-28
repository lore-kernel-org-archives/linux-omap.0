From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: "Dummy" regulator possible?
Date: Thu, 28 May 2009 11:45:15 +0300
Message-ID: <1243500315.32558.27.camel@tubuntu>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28992 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758559AbZE1IqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 04:46:20 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4S8kBIS018752
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 11:46:15 +0300
Received: from [172.21.42.218] (esdhcp042218.research.nokia.com [172.21.42.218])
	by mgw-da02.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4S8jE2C015090
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 11:45:14 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Let's say I have a device that requires power from a regulator, like
OMAP3430 SDP Sharp LCD's "Vcc".

Then I have two boards with the same device. One board gives power to
the device from an always-on regulator, like SDP does with VBAT going to
the LCD. The other board gives power to the device from a controllable
regulator, say, VAUXy.

Is it possible to create a dummy regulator, so that the device driver
could always ask for Vcc supply, and get it, even when it's connected to
a always-on regulator?

Or what would be the correct approach to this?

 Tomi


