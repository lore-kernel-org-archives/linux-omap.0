From: Kevin Hilman <khilman@ti.com>
Subject: boot hang using OMAP for-next + Russell's for-linus
Date: Fri, 27 May 2011 14:27:58 -0700
Message-ID: <87d3j3x28x.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50598 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754840Ab1E0V2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 17:28:02 -0400
Received: by mail-px0-f177.google.com with SMTP id 10so1451753pxi.36
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 14:28:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>

FYI... I just found this, but won't be able to look into it until next
week, so if anyone needs a weekend debug project...

Using Tony's for-next branch, I'm able to boot an omap2plus_defconfig (+
busybox initramfs) kernel on my 3430/n900 just fine.   I then tried to
merge in Russell's for-linus branch and it hangs during boot.

It appears to hang in the init/registration of i2c busses.  Commenting
out the i2c bus registration from board-rx51-peripherals and disabling a
few of the users of i2c, I was able to boot.

Kevin
