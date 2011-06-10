From: Steve Sakoman <sakoman@gmail.com>
Subject: OMAP watchdog broken on 37XX?
Date: Fri, 10 Jun 2011 08:21:22 -0700
Message-ID: <BANLkTik8mEWLrCf03qhFSrcfsNh0F_Wm9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46797 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597Ab1FJPVX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 11:21:23 -0400
Received: by vxi39 with SMTP id 39so2248601vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Jun 2011 08:21:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've used the omap watchdog timer (CONFIG_OMAP_WATCHDOG=y &
CONFIG_WATCHDOG_NOWAYOUT=y) with good results on 35XX based systems.

Recently I attempted to use the the same technique with 37XX and
discovered that my systems hangs instead of rebooting.

The simplest method to test is to do:

# echo 1 > /dev/watchdog
omap_wdt: Unexpected close, not stopping!

On 35XX the system will reboot in one minute as expected.

On 37XX the system the systems hangs in one minute.

Has anyone else encountered this?

Steve
