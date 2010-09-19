From: Peter Barada <peter.barada@gmail.com>
Subject: How to enable sys_clkout1 for use by brf6300
Date: Sun, 19 Sep 2010 12:46:27 -0400
Message-ID: <AANLkTim9o3XdNAK5shVm8u6wa8_0rV7i9PkR3-qgskYK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51682 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab0ISQq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Sep 2010 12:46:28 -0400
Received: by gxk23 with SMTP id 23so1117072gxk.19
        for <linux-omap@vger.kernel.org>; Sun, 19 Sep 2010 09:46:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

All,

I have a brf6300 that requires sys_clkout1, and I have it working fine
right now, but if I enable CONFIG_OMAP_RESET_CLOCKS, then
sys_clkou1 is disabled.

How do I tell the system that I need sys_clkout1 enabled for the
brf6300 chip to work?  Should I use "clk = clk_get(NULL,
"sys_clkout1"); clk_enable(clk)'"?

Thanks in advance!
