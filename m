From: Felix Xiaozhu Lin <xzl@rice.edu>
Subject: n8x0 idle power problem
Date: Sat, 24 Oct 2009 07:40:14 +0800
Message-ID: <f25d86460910231640i22e5da83q1094e60c2e4df05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55475 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbZJWXkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 19:40:10 -0400
Received: by yxe17 with SMTP id 17so8421269yxe.33
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 16:40:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am trying to compile a linux-omap kernel for n810 that can do good
idle power management.

However, this seems to be harder than I expected. I've done all
following measurements with /sys/power/sleep_while_idle set to 1.
Compiler is arm-linux-gnueabi-gcc 4.2. I use n8x0_defconfig.

  * Maemo kernel (2.6.21) consumes ~0mA@3.8V when idle. This seems to
be perfect. However, it has no pm regarding serial port. Whenever
serial port is enabled, idle power is ~50mA@3.8V.

  * I've compiled 2.6.28/2.6.29 from l-o git. Serial port pm works
fine. However the idle power is ~20mA@3.8V. That is quite strange.

  * For kernel >= 2.6.30 I didn't manage to boot my N810.

I also dig out a thread discussing about N8x0 idle power:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg11954.html

where Kalle mentioned 2.6.29 idle power is OK. But I never get the same result.

I'm wondering if I did something wrong in the measurement. Anybody did
the same thing? You suggestion is highly appreciated.

Thanks,

-Felix
