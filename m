From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] usb: musb: fix Kconfig regression
Date: Fri, 27 Feb 2015 23:56:14 +0100
Message-ID: <20150227225614.GC17650@amd>
References: <20150217185518.GA3825@amd>
 <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
 <20150227153809.GS11056@atomide.com>
 <7445620.7S2XydQea5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7445620.7S2XydQea5@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, sre@debian.org, kernel list <linux-kernel@vger.kernel.org>, sre@ring0.de, Sakari Ailus <sakari.ailus@iki.fi>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Fri 2015-02-27 21:12:45, Arnd Bergmann wrote:
> A recent bug fix I did that was marked for stable backports
> introduced a slightly wrong dependency on CONFIG_OMAP_CONTROL_PHY.
> 
> I was missing the fact that the PHY driver already stubs out the
> omap_control_usb_set_mode, and we only need to add a dependency
> to prevent the musb-omap2430 driver from being built-in when
> the phy driver is a loadable module, but we should not prevent it
> from being built altogether when the phy driver is disabled.
> 
> This changes the dependency to allow OMAP_CONTROL_PHY to
> be disabled, but to disallow USB_MUSB_OMAP2PLUS from being
> built-in if OMAP_CONTROL_PHY is a loadable module.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ca784be36cc725 ("usb: start using the control module driver")
> Cc: <stable@vger.kernel.org> # v3.9+
> Cc: Felipe Balbi <balbi@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
