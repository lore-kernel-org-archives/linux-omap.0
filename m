From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.12-rc1: no longer compiles for Nokia n900 (omap based),
 display no longer works
Date: Thu, 26 Sep 2013 02:23:49 +0200
Message-ID: <20130926002349.GA26599@amd.pavel.ucw.cz>
References: <20130919093002.GA23806@amd.pavel.ucw.cz>
 <20130919094402.GA27253@amd.pavel.ucw.cz>
 <20130919184703.GE30568@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130919184703.GE30568@blackmetal.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, catalin.marinas@arm.com
List-Id: linux-omap@vger.kernel.org

Hi!

> On Thu, Sep 19, 2013 at 11:44:02AM +0200, Pavel Machek wrote:
> > something in 3.12-rc1 broke display :-(. (dmesg diff attached at the
> > end, maybe someone knows...)
> 
> 3.12-rc1 for N900 compiles and works (also display) here with binutils
> 2.23.2.

I updated to eldk-5.4, and now it compiles, but still no display on 

> > + omapfb omapfb: no displays
> 
> [...]
> 
> > - acx565akm spi1.2: omapfb: acx565akm rev 12 LCD detected
> 
> I think this is because the panel driver has changed, and the old one
> was deleted. You need to change your kernel configuration with something
> like below:
> 
> -CONFIG_PANEL_ACX565AKM=y
> +CONFIG_DISPLAY_PANEL_SONY_ACX565AKM=y

Thanks for the hint.. but apparently it was not enough. Still no
display on qemu :-(.

Anyway, "make oldconfig" is expected to produce working kernel, which
is clearly not case here. Perhaps this should be added to fix that?

[Who can take the patch?]
   	       	    	  	       	      	       	      Pavel

PS: whoever named directory in kernel sources "displays-new" should...
think again.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

index 6c90885..d3eabd2 100644
--- a/drivers/video/omap2/displays-new/Kconfig
+++ b/drivers/video/omap2/displays-new/Kconfig
@@ -40,6 +40,7 @@ config DISPLAY_PANEL_DSI_CM
 
 config DISPLAY_PANEL_SONY_ACX565AKM
 	tristate "ACX565AKM Panel"
+	default PANEL_ACX565AKM
 	depends on SPI && BACKLIGHT_CLASS_DEVICE
 	help
 	  This is the LCD panel used on Nokia N900

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
