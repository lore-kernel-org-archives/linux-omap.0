From: Emmanuel Vadot <manu@bidouilliste.com>
Subject: Re: [PATCH] ARM: dts: Set status to disable for MMC3
Date: Mon, 7 Oct 2019 19:29:22 +0200
Message-ID: <20191007192922.7ce3423bd1fd03551487e907@bidouilliste.com>
References: <20191007080339.57209-1-manu@freebsd.org>
        <20191007161634.GS5610@atomide.com>
        <20191007183830.71e1303d6bd713014dc36710@bidouilliste.com>
        <20191007165859.GV5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007165859.GV5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Emmanuel Vadot <manu@freebsd.org>, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Oct 2019 09:58:59 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Emmanuel Vadot <manu@bidouilliste.com> [191007 16:39]:
> > On Mon, 7 Oct 2019 09:16:34 -0700
> > Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > Hi,
> > > 
> > > * Emmanuel Vadot <manu@freebsd.org> [191007 08:04]:
> > > > Commit 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
> > > > fixed the mmc instances on the l3 interconnect but removed the disabled status.
> > > > Fix this and let boards properly define it if it have it.
> > > 
> > > The dts default is "okay", and should be fine for all the
> > > internal devices even if not pinned out on the board. This
> > > way the devices get properly idled during boot, and we
> > > avoid repeating status = "enabled" over and over again in
> > > the board specific dts files.
> > 
> >  That is not correct, if a status != "disabled" then pinmuxing will be
> > configured for this device and if multiple devices share the same pin
> > then you have a problem. Note that I have (almost) no knowledge on Ti
> > SoC but I doubt that this is not the case on them.
> 
> Hmm well, that should not be needed. The pinmux configuration is always
> done in a board specific dts file.

 For TI it seems to be that way, but clearly not for other brand.

> >  Also every other boards that I work with use the standard of setting
> > every node to disabled in the dtsi and let the board enable them at
> > will. Is there something different happening in the TI world ?
> 
> There should be no need to do that for SoC internal devices, the
> the default status = "okay" should be just fine. Setting the
> status = "disabled" for SoC internal devices and then enabling them
> again for tens of board specific dts files just generates tons of
> pointless extra churn for the board specific configuration.

 Setting the status = "okay" means that you can use the device. What's
the point of enabling a device if you can't use it ? Or worse can't
probe it like i2c or spi ?
 Is the plan for TI dts to have every (or almost) device tree node
enabled even if the device isn't usable on the board ?

> > > Then the board specific dts files might want to configure
> > > devices with status = "disabled" if really needed. But this
> > > should be only done for devices that Linux must not use,
> > > such as crypto acclerators on secure devices if claimed by
> > > the secure mode.
> > > 
> > > So if this fixes something, it's almost certainly a sign
> > > of something else being broken?
> > 
> >  In this case it's FreeBSD being  because (I think) we have bad support
> > for the clocks for this module so we panic when we read from it as the
> > module isn't clocked. And since I find it wrong to have device enabled
> > while it isn't present I've sent this patch.
> 
> Thanks for clarifying what happens. OK, sounds like FreeBSD might be
> missing clock handling for some devices then.
> 
> What Linux does is probe the internal devices and then idle the
> unused ones as bootloaders often leave many things enabled. Otherwise
> the SoC power management won't work properly because device clocks
> will block deeper SoC idle states.

 I can understand stand but then the bootload should be fixed to not
enable devices that aren't enabled in the DTS if it does that.

> Regards,
> 
> Tony
> 
> > > > Fixes: 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
> > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > > ---
> > > >  arch/arm/boot/dts/am33xx.dtsi | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > > > index fb6b8aa12cc5..b3a1fd9e39fa 100644
> > > > --- a/arch/arm/boot/dts/am33xx.dtsi
> > > > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > > > @@ -260,6 +260,7 @@
> > > >  				ti,needs-special-reset;
> > > >  				interrupts = <29>;
> > > >  				reg = <0x0 0x1000>;
> > > > +				status = "disabled";
> > > >  			};
> > > >  		};
> > > >  
> > > > -- 
> > > > 2.22.0
> > > > 
> > 
> > 
> > -- 
> > Emmanuel Vadot <manu@bidouilliste.com>


-- 
Emmanuel Vadot <manu@bidouilliste.com>
