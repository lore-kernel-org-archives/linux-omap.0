From: Peter Barada <peter.barada@gmail.com>
Subject: using gpiolib driver to manipulate GPIO pins
Date: Fri, 7 May 2010 12:35:22 -0400
Message-ID: <w2h738b3f7e1005070935l8b136f6brffa2a5f41b275d5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49291 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198Ab0EGQfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 12:35:23 -0400
Received: by gyg13 with SMTP id 13so721876gyg.19
        for <linux-omap@vger.kernel.org>; Fri, 07 May 2010 09:35:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm trying to use the gpio driver in 2.6.32 to manipulate a pin after
the kernel comes up(via /sys/class/gpio/...), and I can tweak the gpio
value,
but the gpio driver does not handle the mux setting to set the mux
mode (or input/output/pullup/puldown) to 4 for the particular pin.

I've looked at the latest in LImus' tree and do not see any code in
the driver/gpio/gpiolib.c to handle the muxing....

Am I going about this all wrong?
