From: Frederik Kriewitz <frederik@kriewitz.eu>
Subject: OMAPFB: LL pointer dereference because of uninitialized mutex
Date: Tue, 18 Aug 2009 15:32:10 +0200
Message-ID: <f67028d40908180632l26e62512n8e342629faeda36d@mail.gmail.com>
Reply-To: frederik@kriewitz.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:3373 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbZHRNeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 09:34:05 -0400
Received: by fg-out-1718.google.com with SMTP id e12so598902fga.17
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 06:34:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm trying to add support for a omap3 board.

But I get a NULL pointer dereference during initialization of the lcd
panel driver because framebufferInfo->mm_lock wasn't initialized.

Code of the lcd driver: http://pastebin.com/m44ccc56d (nothing special)

Stack trace:
__mutex_lock_slowpath()
mutex_lock()
set_fb_fix()
omapfb_do_probe()
devkit8000_panel_probe() << my probe function
platform_drv_probe()
...

It get's initialized in register_framebuffer() but in my case the
probe function gets called before register_framebuffer().

Once I added the missing inits to framebuffer_alloc()
(drivers/video/fbsysfs.c) it works fine:
mutex_init(&info->lock);
mutex_init(&info->mm_lock);

How I'm intended to fix this?
