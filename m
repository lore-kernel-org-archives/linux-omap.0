From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] omapdss: Add new panel driver for Topolly td028ttec1
 LCD.
Date: Thu, 10 Oct 2013 14:26:16 +0200
Message-ID: <52569CE8.5070201@metafoo.de>
References: <1381352915-17219-1-git-send-email-marek@goldelico.com> <525662F5.3090600@ti.com> <7FAC77D4-5E1E-4B11-B067-3A8233C69240@goldelico.com> <52568B40.4040802@ti.com> <04AC7291-38E4-421B-979C-BF03D52E94BD@goldelico.com> <525699EF.6090803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <525699EF.6090803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/10/2013 02:13 PM, Tomi Valkeinen wrote:
> On 10/10/13 14:52, Dr. H. Nikolaus Schaller wrote:
> 
>> Yes, I agree and I am willing to help if someone comes up with such a SoC.
>> At the moment we have connected it to the OMAP3 only.
> 
> True, but even without that kind of SoC, SPI bitbanging should be
> handled by an SPI driver, not by the drivers that use the bus.
> 
>> I.e. I want not to do a lot of work for others who we just guess about that they
>> might exist...
> 
> Yep. It's fine for me, it's not that much extra code in the panel driver.
> 
>>> The panel hardware has three wires, so the panel driver (if it does
>>> handle the bus by bitbanging) can only refer to three gpios.
>>
>> Hm. The panle hardware has 3 but the SoC (OMAP3) the driver
>> is running on has 4.
> 
> Right, but this panel driver is a driver for the panel hardware. Not for
> the SoC, or the SoC+panel combination. So the panel driver must only use
> resources as seen by the panel hardware.
> 
>>> So either
>>> the bus details should be hidden by using the normal spi framework, or
>>> if the driver does the bitbanging, use the gpios as specified in the
>>> panel spec. The panel driver cannot contain any board specific stuff.
>>
>> The bitbang driver shown below can handle either 3 or 4 gpios (except
>> for initialization).
> 
> It's not a bitbang driver, it's a panel driver. And anyway, if I
> understood right, your use of 4 gpios was just a hack to try to make it
> look like a normal 4-wire SPI bus. What you really have is 3 wires, 3
> gpios. I don't see any reason to use 4 gpios, as two of them are the same.
> 
> Hmm, how does it work anyway. Did I understand it right, the panel's
> 'DIN' pin is connected to two gpios on the SoC, and one of those gpios
> is set as output, and the other as input? So the SoC is always pulling
> that line up or down, and the panel is also pulling it up or down when
> it's sending data. I'm no HW guy but that sounds quite bad =).
> 
> I've never written or studied a bitbanging driver, but shouldn't there
> be just one gpio used on the SoC for DIN, and it would be set to either
> output or input mode, depending on if we are reading or writing?

Back in the OpenMoko days we used the panel in normal 4-wire SPI mode with
the GPIO bitbang SPI master. The bitbang code in this driver also looks like
normal 4 wire.

- Lars
