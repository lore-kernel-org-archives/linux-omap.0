From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: gpio_wp pin not set correctly
Date: Mon, 05 Sep 2011 23:01:21 +0200
Message-ID: <4E6538A1.5090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38096 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab1IEVA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 17:00:26 -0400
Received: by eyx24 with SMTP id 24so3656863eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 14:00:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, silesh@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

I bisected commit 5e4698fc4406b8603913a2eff44b7c44c5924ea4 for the
following boot error message.

[    0.361694] _omap_mux_init_gpio: Could not set gpio192

When I revert the commit with actual linux-omap, the message is away.

Can you please check this?

I use a Devkit8000, but the beagleboard should have the same problem.


Thomas

