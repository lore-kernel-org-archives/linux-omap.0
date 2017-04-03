From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/7] mfd: retu: Add OF device ID table
Date: Mon, 3 Apr 2017 15:58:13 -0700
Message-ID: <20170403225813.GJ10760@atomide.com>
References: <20170401071854.23198-1-javier@osg.samsung.com>
 <20170401071854.23198-3-javier@osg.samsung.com>
 <20170403111502.lotjpd746vkhekkg@dell>
 <2147b8c9-02ee-1b9c-a74e-119b0b73d1d7@osg.samsung.com>
 <20170403222010.xgbf7imyieyfroqr@rob-hp-laptop>
 <a852be9e-e1f0-0975-abd0-a4a61f3a9750@osg.samsung.com>
 <20170403225342.eqyh3van4q6bxpuv@raspberrypi-3.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170403225342.eqyh3van4q6bxpuv@raspberrypi-3.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [170403 15:56]:
> Hi,
> 
> On Mon, Apr 03, 2017 at 06:24:39PM -0400, Javier Martinez Canillas wrote:
> > On 04/03/2017 06:20 PM, Rob Herring wrote:
> > > On Mon, Apr 03, 2017 at 11:45:14AM -0400, Javier Martinez Canillas wrote:
> > >> Hello Lee,
> > >>
> > >> On 04/03/2017 07:15 AM, Lee Jones wrote:
> > >>
> > >> [snip]
> > >>
> > >>>>  
> > >>>> +static const struct of_device_id retu_of_match[] = {
> > >>>> +	{ .compatible = "nokia,retu-mfd" },
> > >>>> +	{ .compatible = "nokia,tahvo-mfd" },
> > >>>
> > >>> Please drop the "-mfd".
> > >>>
> > >>
> > >> Yes, I also didn't like it but I didn't want to change it since that would
> > >> mean that backward compatiblity and bisect-ability will be broken by this
> > >> change.
> > >>
> > >> In other words, just adding a vendor prefix won't cause an issue if patches
> > >> are merged independently since if DTS patches are merged before, the driver
> > >> will still lookup using the I2C device ID table. And if the drivers patches
> > >> are picked before, the DTS will match using the OF device ID table.
> > >>
> > >> But changing to "nokia,retu" and "nokia,tahvo" means that you will need to
> > >> pick all patches and also that the DTS and drivers changes will have to be
> > >> done in the same patch. If you are OK with that, then I can change in the
> > >> next version.
> > > 
> > > tahvo is not documented nor used in any dts (in the kernel at least). 
> 
> True, there are no known DT users of Tahvo.
> 
> > > retu is used by 1 board and happened to work, but was never documented. 
> > > So I think it is okay to change unless the N800 folks object.
> > 
> > I'm fine with changing it (in fact I just want to fix the I2C of modalias
> > reporting). Does this mean that backward compatibility and bisect-ability
> > should be preserved? Or it's OK to split the changes in different patches?
> 
> There are 2 boards actually, N800 and N810. Retu is critical, because
> if retu-mfd/watchdog fails to probe the device will power off soon after
> boot. So for bisect-ability you should make changes in a single patch.

Also I wonder if this will work with arch/arm/mach-omap1/board-nokia770.c
that does I2C_BOARD_INFO("tahvo-mfd", 0x02). Seems they all need to be
changed with a single patch?

Regards,

Tony
