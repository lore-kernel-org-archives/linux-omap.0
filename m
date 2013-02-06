From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: how to specify an OMAP clock in device tree?
Date: Wed, 6 Feb 2013 15:51:52 +0530
Message-ID: <51122EC0.3040804@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-12-git-send-email-rogerq@ti.com> <5110D229.1000808@ti.com> <5110E9C4.9000301@ti.com> <51110D4B.50904@ti.com> <51111371.6050502@ti.com> <511114C1.4050809@ti.com> <5111157D.7040803@ti.com> <51111739.2050805@ti.com> <511118FE.7020405@ti.com> <51111CC4.1060004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56297 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab3BFKWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 05:22:19 -0500
In-Reply-To: <51111CC4.1060004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, paul@pwsan.com

On Tuesday 05 February 2013 08:22 PM, Roger Quadros wrote:
> Doesn't look very elegant to me, but I wouldn't mind if there is no better option.
> Even then, we can't rely on the device name as its index can change based on where it is

Well, thats what I said in the first mail, that *if* you are able to
fix the device name, *then* we could use clkdev the way its used in
non-DT case. But then you came back saying 'Fixing the device name
doesn't really solve the problem.' :)

> located in the dts file. e.g. in the beginning it may be named phy.8, and if a device
> node is added before it, it will get changed to phy.9

If you provide a phandle to the PHY node in the board node, for which
you need to add the clk alias, you can always extract the device (using
of_find_device_by_node() ) and hence its name, so it doesn't matter if
its phy.8 or phy.9.
