From: Pavel Machek <pavel@ucw.cz>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Mon, 20 Oct 2014 15:08:55 +0200
Message-ID: <20141020130855.GA1067@amd>
References: <20141019090107.GA19132@amd>
 <201410191658.45851@pali>
 <20141019205033.GA4738@amd>
 <201410192300.20625@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201410192300.20625@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, kishon@ti.com, s.nawrocki@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi!

> My N900 can boot kernel from v3.12-rc5-n900 branch compiled with 
> arch/arm/configs/rx51_defconfig. Also it can boot full Maemo5 
> system (with CSSU and some minor system changes) and usb network 
> via g_nokia.ko gadget working fine...
> 
> So if it does not working for you then kernel usb subsystem could 
> have problems with using gadgets directly from zimage.

After some hand-bisecting and real-bisecting, I found two commits that
cause problems for 3.13: With these reverted, I get usb networking
back in 3.13 on nokia n900.

(Pali, if you revert these, you should get working usb networking in
your 3.13 branch, too.)

Any ideas?

								Pavel

commit 3e3101d57c50f9e4fa1da947e4bd0bc5cbab4141
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Fri Sep 27 11:53:30 2013 +0530

    usb: musb: omap2430: use the new generic PHY framework
    
    Use the generic PHY framework API to get the PHY. The
    usb_phy_set_resume
    and usb_phy_set_suspend is replaced with power_on and
    power_off to align with the new PHY framework.
    
    musb->xceiv can't be removed as of now because musb core uses
    xceiv.state and
    xceiv.otg. Once there is a separate state machine to handle otg,
    these can be
    moved out of xceiv and then we can start using the generic PHY
    framework.
    
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
    Acked-by: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit f1ddc24c9e33813f74b871d73e4d795dcdb95a3c
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Fri Sep 27 11:53:31 2013 +0530

    usb: phy: twl4030-usb: remove *set_suspend* and *phy_init* ops
    
    Now that twl4030-usb is adapted to the new generic PHY framework,
    *set_suspend* and *phy_init* ops can be removed from twl4030-usb
    driver.
    
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Acked-by: Felipe Balbi <balbi@ti.com>
    Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>





-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
