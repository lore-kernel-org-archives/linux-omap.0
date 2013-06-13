From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 device tree conversion: how to do first step
Date: Thu, 13 Jun 2013 07:10:01 -0700
Message-ID: <20130613141001.GF8164@atomide.com>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <20130609201119.GA3190@blackmetal.musicnaut.iki.fi>
 <20130613132624.GA3464@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130613132624.GA3464@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [130613 06:32]:
> Hi!
> 
> > > I'd like to convert Nokia N900 to device tree.
> > > 
> > > Unfortunately, serial port is not easily available (very special cable
> > > would be needed, does someone know where to get one?) and I don't have
> > > BDI (and very special cable would be needed, too).
> > > 
> > > So I tried doing very small first step, hoping that I get booting
> > > system... obviously I did not.
> > 
> > The following works for me, it's enough to boot and get the USB networking
> > working. After that I can connect to the device with ssh. I don't use
> > serial either, I just have initramfs with busybox+dropbear with hardcoded
> > interface setup.
> 
> Nice.... thanks a lot.
> 
> Did you get video to work with the device tree? That's what I'd like
> to accomplish now.

The DSS code is still using pdata, see mach-omap2/dss-common.[ch].
 
> If I init spi manually (and some more hacks), it works in the
> qemu. But I have not tested on real hw for a while.

You should be able to initialize spi by adding the .dts entry,
or is there something missing in drivers/spi/spi-omap2-mcspi.c?

Regards,

Tony
