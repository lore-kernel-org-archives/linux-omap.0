From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 08:39:28 -0700
Message-ID: <200809020839.28372.david-b@pacbell.net>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:37456 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751352AbYIBPjb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 11:39:31 -0400
In-Reply-To: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 02 September 2008, Felipe Balbi wrote:
> 
> The following patches convert twl4030-usb to a platform_device
> in order to set the usb mode via platform_data and get
> rid of the Kconfig entry for that.

Shouldn't twl4030 first be converted to be a "new style"
I2C driver?  Then if this approach is to be used, its
probe() would create those platform devices as children
of the I2C device node, and with relevant platform_data.

The platform_data for all those child devices should be
provided as part of the platform_data for the "main" TWL
driver, so everything can be properly board-specific.

Also, since it seems twl4030 docs won't become public
but docs for its catalog versions[0] will, it'd be good
to update file headers and Kconfig to mention tps659x0
parts so that folk without twl4030 NDA's can eventually
work with this code...

- Dave


[0] http://focus.ti.com/docs/prod/folders/print/tps65950.html


