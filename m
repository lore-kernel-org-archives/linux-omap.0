From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: tps65910
Date: Fri, 18 May 2012 10:53:53 +0300
Message-ID: <CAP3+TErDaA9Sdf2yf9asu1kNqRowTAga6NksVW9j4c+fzi9v=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61368 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761269Ab2ERHxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 03:53:54 -0400
Received: by lbbgm6 with SMTP id gm6so1866343lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 00:53:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hey guys!

Who knows how to initialize and use tps65910 driver in linux with
am3517? I designed a board using the Craneboard schematic as a
reference. Mistral provides the kernel 2.6.32 and it works fine. Now
I'm porting the BSP to kernel 3.0.17 and don't know how to implement
voltage regulator features with the tps65910 driver (it appeared in
kernel 3.0 ) under kernel 3.0 environment.

I'm watching board-omap3beagle.c as a reference and tps65910.c driver
and can't find any correlation. Any suggestions?

Any help is appreciated!

Max
