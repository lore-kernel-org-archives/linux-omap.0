From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc7-omap-git 0/2] twl4030 uses gpiolib
Date: Thu, 25 Sep 2008 19:33:10 -0700
Message-ID: <200809251933.10439.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:38483 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752542AbYIZCjm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 22:39:42 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Two patches follow ... they go on top of (a) the four from Felipe,
which he's updating to move the twl_has_XYZ() macros into the core;
(b) the pullup tweak from Jagadeesh:

 - Define and initialize platform data
 - Be a platform_driver which uses that and gpiolib

There's more work to be done, but this is IMO a good start and
seems mergeable as-is.

- Dave
