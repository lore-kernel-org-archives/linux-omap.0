From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc6-omap-git 0/5] drivers/usb/otg seeding
Date: Mon, 1 Dec 2008 13:11:25 -0800
Message-ID: <200812011311.25404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:40005 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750980AbYLAVya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 16:54:30 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

These five patches go on top of the two twl4030-usb patches sent
last Wednesday.

The first four are in the USB queue (though the fourth has some
minor updates that haven't yet made it there, like speling Tony's
name right) ... the last one moves one more OMAP-only driver out
of drivers/i2c/chips, to help it swim upstream.

 - move drivers/i2c/chips/isp1301-omap.c to drivers/usb/otg
 - add new gpio_vbus "transceiver" (not used for now with OMAP)
 - add missing otg_put_transceiver() call
 - move OMAP's transceiver glue to drivers/usb/otg
 - move drivers/i2c/chips/twl4030-usb.c to drivers/usb/otg

That last patch is the one which will break if the two preceding
patches aren't applied.

After this the twl4030-usb code will more or less be ready to
go upstream ... doesn't yet use regulator framework, but that's
not upstream either.

- Dave
