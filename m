From: Patrick <kpa_info@yahoo.fr>
Subject: [DSS2] TFT panel not working (only one column visible)
Date: Thu, 2 Feb 2012 10:56:13 +0000 (GMT)
Message-ID: <1328180173.57481.YahooMailNeo@web29017.mail.ird.yahoo.com>
Reply-To: Patrick <kpa_info@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm7.bullet.mail.ird.yahoo.com ([77.238.189.21]:46450 "HELO
	nm7.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755290Ab2BBK4O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Feb 2012 05:56:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dear mailing-list,

I am using an AM-320240LETMQW LCD module connected to an OMAP4430.
This module use the same display driver as the lb035q02 (the HX8238), so I have used the panel-lgphilips-lb035q02 driver as a starting point for my driver.

When using fb-test or using dd if=/dev/urandom of=/dev/fb only the first (left) column (and not row) display some pixels.
All the rest is black...

I have checked with a scope that the pixclock, hsync and vsync seems ok. I don't know what to test more.

Do you have any idea what can cause this kind of problems ? The working line seems to work fine the pixels are stable.

Thanks in advance for any help

Patrick
