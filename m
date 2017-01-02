From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 20:49:45 +0200
Message-ID: <20170102184945.m6maflaoihumd7nt@raspberrypi-2.musicnaut.iki.fi>
References: <201701012054.54505@pali>
 <6462f543-0422-8146-a196-f4e07c3ebb6f@ti.com>
 <20170102084432.GA6728@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102084432.GA6728@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jan 02, 2017 at 09:44:32AM +0100, Pali Rohár wrote:
> On Monday 02 January 2017 10:23:23 Peter Ujfalusi wrote:
> > GPIO_182 is to select where to route the MIC line from the jack for the
> > ECI core to handle (when the TVOUT is disabled).
> 
> Yes, already figured out from schematic.
> 
> > I have no idea what the
> > gpio_178 should have been used for. It might be only needed for early
> > protos but not in production devices?
> 
> I do not know, reason why I'm asking.

The schematic shows ECI(5:0), but only 3 are connected/used. There were
3 other GPIOs reserved but not used in the final product.

A.
