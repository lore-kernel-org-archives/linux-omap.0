From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] i2c_omap: correct OMAP_I2C_SYSC_REG offset
Date: Fri, 09 Dec 2011 10:03:29 -0800
Message-ID: <874nx9hbbi.fsf@ti.com>
References: <1323355433-8508-1-git-send-email-a.aring@phytec.de>
	<87obvjj5l5.fsf@ti.com> <4EE11091.20404@ti.com>
	<4EE1AEA8.6000008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52441 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751238Ab1LISDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 13:03:33 -0500
In-Reply-To: <4EE1AEA8.6000008@ti.com> (shubhrajyoti@ti.com's message of "Fri,
	09 Dec 2011 12:16:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Jon Hunter <jon-hunter@ti.com>, Alexander Aring <a.aring@phytec.de>, linux-omap@vger.kernel.org, ben-linux@fluff.org, tony@atomide.com, linux-i2c@vger.kernel.org, Shubhrajyoti <shubhrajyoti@ti.com>

Ben,

[...]

>>> Shubhrajyoti/Jon, any objections to me queuing this fix for v3.2 (and
>>> stable.)  It would just mean rebasing your other fixes and cleanup
>>> series on top of this.
>>
>> I have no issue with that and I am in favour of getting the fix in now.
> I too have no issues.

I've queued this fix in my i2c fixes branch[1], and added a 
Cc: stable@kernel.org so it makes it into stable as well.

Note, This branch also includes the other fix I sent a couple days
ago[2], so pulling this branch will get you all the OMAP I2C fixes for
v3.2.

Thanks,

Kevin

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/i2c

[2] Subject: [PATCH] I2C: OMAP: fix FIFO usage for OMAP4.
