From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Wed, 25 Oct 2017 14:28:07 -0700
Message-ID: <20171025212806.GA21504@atomide.com>
References: <20171025203459.GA22035@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171025203459.GA22035@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [171025 13:36]:
> Hi!
> 
> ...hardware should be identical. 3.5.3-nemo kernel seems to work on
> both. 4.13-rc2 with display and clock patches boots on phone "S", but
> does not on phone "P"; nothing nothing is received on serial port.
> 
> There is some difference in the bootloaders: S's bootloader provides
> lots of debug info, P's is silent. R&D settings do _not_ have
> influence on bootloader. We know P's serial works, as 3.5.3 kernel
> prints "Uncompressing linux...booting" there.
> 
> I'll need to return "S" phone and serial cable tommorow. If you have
> any ideas, let me know.

If you get nothing out of the uart, chances are the pins are
not muxed for the uart in nolo and maybe kernel dts is missing the
pinctrl entries for uart?

Also try booting with mem=512M@0x80000000 or 256M or 768M. Maybe the
memory is different size or partially broken?

Regards,

Tony
