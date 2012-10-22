From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 0/8] I2C patches for v3.8 merge window
Date: Mon, 22 Oct 2012 20:32:01 +0530
Message-ID: <50855FE9.6000806@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com> <20121022133023.GC14033@arwen.pp.htv.fi> <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com> <20121022140658.GA18993@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42238 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747Ab2JVPCf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 11:02:35 -0400
In-Reply-To: <20121022140658.GA18993@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Monday 22 October 2012 07:36 PM, Felipe Balbi wrote:
> can you also check if echo mem > /sys/power/state works ? Don't forget
> to enable UART wakeups with:
>
> echo enabled > /sys/devices/platform/omap_uart.2/power/wakeup
> echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
>
> before trying to suspend. Another cool test is rtctest (since our RTC is
> part of TWL). It worked fine on my two platforms. Attached you will find
> the sourcecode for rtctest.
On omap3 tested . with off hitting both in suspend and idle path.


Also with rtcwake.

Thanks

