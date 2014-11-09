From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sound: enable sound support on n900 on devicetree-based boot
Date: Sun, 9 Nov 2014 20:39:53 +0100
Message-ID: <20141109193953.GA7852@amd>
References: <20141109120222.GA3815@amd>
 <20141109123753.GO2722@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141109123753.GO2722@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@debian.org>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, peter.ujfalusi@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Sun 2014-11-09 12:37:53, Mark Brown wrote:
> On Sun, Nov 09, 2014 at 01:02:22PM +0100, Pavel Machek wrote:
> > 
> > With device tree, it is possible (and encouraged) to build N900
> > kernels without CONFIG_MACH_NOKIA_RX51. Update config file to enable
> > the driver build in this case.
> 
> Please do try to use subject lines reflecting the style for the
> subsystem.

Ok.

> >  config SND_OMAP_SOC_RX51
> >  	tristate "SoC Audio support for Nokia RX-51"
> > -	depends on SND_OMAP_SOC && ARM && (MACH_NOKIA_RX51 || COMPILE_TEST) && I2C
> > +	depends on SND_OMAP_SOC && ARM && I2C
> 
> Please also update the config text so users have a chance to figure out
> that this driver is the one they need for their system - I guess most
> people won't know what RX-51 is.

Actually help text below already explains that. I'll update tristate
text, too.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
