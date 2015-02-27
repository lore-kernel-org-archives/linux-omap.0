From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH, RESEND] usb: musb: fix Kconfig regression
Date: Sat, 28 Feb 2015 01:51:03 +0200
Message-ID: <20150227235103.GB590@fuloong-minipc.musicnaut.iki.fi>
References: <2671702.mSdaGStNT3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2671702.mSdaGStNT3@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, sre@debian.org, kernel list <linux-kernel@vger.kernel.org>, sre@ring0.de, Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, Feb 28, 2015 at 12:19:41AM +0100, Arnd Bergmann wrote:
> A recent bug fix I did that was marked for stable backports
> introduced a slightly wrong dependency on CONFIG_OMAP_CONTROL_PHY.
> 
> I was missing the fact that the PHY driver already stubs out the
> omap_control_usb_set_mode, and we only need to add a dependency
> to prevent the musb-omap2430 driver from being built-in when
> the phy driver is a loadable module, but we should not prevent it
> from being built altogether when the phy driver is disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ca784be36cc725 ("usb: start using the control module driver")
> Acked-by: Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: <stable@vger.kernel.org> # v3.9+

This patch allows me to disable redundant CONFIG_OMAP_CONTROL_PHY
from 4.0-rc1 .config and still get a working USB on Nokia N9. So:

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
