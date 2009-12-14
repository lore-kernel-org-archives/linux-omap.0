From: John Faith <jfaith7@gmail.com>
Subject: Enabling 3530 sys_clkout2
Date: Mon, 14 Dec 2009 12:30:34 -0800
Message-ID: <e0727e900912141230q1e98d4c3ge408101664a0c712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57214 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943AbZLNUae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 15:30:34 -0500
Received: by pwj9 with SMTP id 9so2157624pwj.21
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 12:30:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
I'm trying to enable the sys_clkout2 pin in a 2.6.29 kernel for my
3530EVM-like board for the main clock line of an FPGA.  I've added a
MUX_CFG_34XX entry in mux.c, set the gpio direction in my board.c
file, and set the rate in my driver with clk_set_parent(),
clk_set_rate() but I do not see any output clock when probed with a
scope.

I see that sound/soc/omap/n810.c also uses sys_clkout2, but even when
I try setting the same parent and rate, I get nothing out.  Is there
anything special about this clock that requires extra care?

Thanks,
John
