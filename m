From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Commit 0c8219f0... breaks omap7xx support
Date: Sat, 6 Mar 2010 20:56:50 -0800
Message-ID: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59078 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab0CGE5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Mar 2010 23:57:10 -0500
Received: by pwj8 with SMTP id 8so3156147pwj.19
        for <linux-omap@vger.kernel.org>; Sat, 06 Mar 2010 20:57:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com
Cc: linwizard-devel@lists.sf.net

All,

I've finally gotten some time to test the latest linux-omap code, and
found the following commit:

    4f2c49fedf... omap: Clean the serial port defines

breaks current omap7xx support.  To get linux-omap master to boot, I
had to revert that, and the three two that follow it:

    0c8219f03... omap: Make uncompress code and DEBUG_LL code generic
    61b603b4e...omap: Remove old DEBUG_LL serial port options

in order to boot with DEBUG_LL enabled.  Disabled, I only needed to
revert the last two.

I don't know enough about that part of the kernel to debug it, so all
I can offer is a test result.  For reference, this was on
board-htcherald using the htcherald_defconfig settings.

- Cory
