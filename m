From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Modifying the kernel keymap
Date: Sun, 15 Nov 2009 12:06:29 -0800
Message-ID: <6cb013310911151206s2496a6edxb3101d2d96c8dea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:41042 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbZKOUGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 15:06:43 -0500
Received: by pwi3 with SMTP id 3so2889072pwi.21
        for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2009 12:06:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

All,

I'm working with the Wing Linux and Linwizard projects in porting
various omap850-based devices to Linux, and was wondering about
keymaps.

In particular, I'm working with the HTC Herald, which uses an Alt key
to access things like numbers and symbols on a physical keyboard.  In
Linux, the keymappings are wrong for this -- Alt does something
different and doesn't allow access to those extra characters.

In Linwizard, we've modified the defkeymap and added makefile rules to
compile our modified defkeymap when a specific board was selected, but
this isn't portable when building a kernel for many boards at once,
each having a different mapping.

So, my question is, what is the best way to go about changing the
defkeymap, or supplying a keymap that allows all the keys to function
correctly, but doesn't require non-portable makefile hacks?

Thanks,
Cory
