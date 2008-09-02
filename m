From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 15:34:46 +0300
Message-ID: <20080902123446.GC7089@gandalf.research.nokia.com>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56546 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYIBMew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 08:34:52 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m82CYnIO014920
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 07:34:50 -0500
Content-Disposition: inline
In-Reply-To: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 02, 2008 at 03:31:50PM +0300, Felipe Balbi wrote:
> The following patches convert twl4030-usb to a platform_device
> in order to set the usb mode via platform_data and get
> rid of the Kconfig entry for that.
> 
> Later, we add a sysfs entry for reporting the vbus events
> coming from triton, this let's us tell the userspace we
> have a usb connection (vbus is on) and trigger an application
> or something else.

Just one comment here. I'll apply these to the big series of drivers
going to mainline.

TWL4030 driver won't be accepted the way it is now. Starting from the
fact that twl4030-core is an old style i2c driver and Jean Delvare
already stated his plans to drop support for old style i2c drivers.

twl4030-usb is already moved to platform_driver, twl4030_gpio should be
moved to gpiolib also before sending to mainline.

Comments are really welcome.

-- 
balbi
