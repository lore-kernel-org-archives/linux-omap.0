From: Pavel Machek <pavel@ucw.cz>
Subject: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Thu, 17 Mar 2016 22:26:03 +0100
Message-ID: <20160317212603.GA16651@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, maxime.ripard@free-electrons.com, ruslan.bilovol@gmail.com, m.szyprowski@samsung.com, peter.chen@freescale.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi!

USB gadget stops working for me on n900, if I merge

usb: gadget: bind UDC by name passed via usb_gadget_driver structure

patch.

commit 2284b29d3d9dd16490909962574d7f3fef83fd97
Author: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Mon Nov 23 09:56:35 2015 +0100

    usb: gadget: bind UDC by name passed via usb_gadget_driver
    structure

    Introduce new 'udc_name' member to usb_gadget_driver structure.
        The 'udc_name' is a name of UDC that usb_gadget_driver should
	    be bound to. If udc_name is NULL, it will be bound to any
	        available UDC.

    Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
        Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
	    Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
	        Tested-by: Peter Chen <peter.chen@freescale.com>
		    Signed-off-by: Felipe Balbi <balbi@ti.com>


Patch is obvious enough... if there's someone who sets udc_name to
NULL. Who is supposed to do that?

(I have patch in my tree to make USB gadget work when it is not
modular).

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
