From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.20-rc0 breaks nfsroot over usb
Date: Fri, 27 Feb 2015 01:03:07 +0200
Message-ID: <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
References: <20150217185518.GA3825@amd>
 <20150226221950.GC10204@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226221950.GC10204@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, Sakari Ailus <sakari.ailus@iki.fi>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Feb 26, 2015 at 11:19:50PM +0100, Pavel Machek wrote:
> Ok, it seems that new config dependencies broke my kconfig. These will
> not be enabled if you just to make oldconfig; you want to make sure
> they are on.
> 
>  OMAP2430 and onwards (USB_MUSB_OMAP2PLUS) [N/m/y] (NEW)
> TWL4030 USB Transceiver Driver (TWL4030_USB) [N/m/y/?] (NEW)

Yes, also other users have reported "USB breakage" with 4.0-rc1 on N900
etc caused by this.

Commit fbba7db3990cb707ff91cd6507d53a0a730afe97 (usb: musb:
add omap-control dependency) changed USB_MUSB_OMAP2PLUS to depend
on OMAP_CONTROL_PHY but that seems to be wrong at least for OMAP3.
omap_control_phy.h provides dummy functions when it's not enabled.
So there should be no dependency.

A.
