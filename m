From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 9/9] ARM: dts: omap4: convert to use the new clkctrl
 clocks for the drivers
Date: Tue, 28 Mar 2017 08:03:16 -0700
Message-ID: <20170328150316.GU10760@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-10-git-send-email-t-kristo@ti.com>
 <20170328001800.GR10760@atomide.com>
 <8b502a89-dcc6-1932-70cc-e887b1404dbb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8b502a89-dcc6-1932-70cc-e887b1404dbb@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170327 22:46]:
> On 28/03/17 03:18, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> > > Convert the drivers to use the new clkctrl clocks.
> > > 
> > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > ---
> > >  arch/arm/boot/dts/omap4.dtsi | 164 ++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 146 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> > > index 3ecf616..c39304a 100644
> > > --- a/arch/arm/boot/dts/omap4.dtsi
> > > +++ b/arch/arm/boot/dts/omap4.dtsi
> > > @@ -94,16 +94,22 @@
> > >  			compatible = "ti,omap4-mpu";
> > >  			ti,hwmods = "mpu";
> > >  			sram = <&ocmcram>;
> > > +			clocks = <&mpuss_clkctrl OMAP4_MPU_CLKCTRL 0>;
> > > +			clock-names = "clkctrl";
> > >  		};
> > 
> > Oh one more thing. I don't think we should add the clocks
> > here as they are now wrongly allocated to the device within
> > the interconnect target module. These clocks really belong
> > to each interconnect target module that we don't have in the
> > dts yet.
> > 
> > So we're better off adding the clockctrl clocks and then
> > changing the dts to use the interconnect target modules
> > with the clockctrl clocks.
> 
> The problem is, you can't just add the clkctrl clock nodes themselves alone,
> as this introduces the problem that any clocks with no users will get
> disabled => causes a boot time hang when all the device clocks get shut
> down.

Hmm yeah. I wonder how to work around that.. What if we first updated
the clocks in the hwmod code? Or updated the aliases?

> If you want to delay the usage of the clocks until you have interconnect
> target modules in place, you need to introduce the clock nodes also at that
> point, similar to what needs to be done now to squash patch #8 or #9.

I'd like to do this one device at a time without any large
flips as we have quite a few devices with special handling for
reset and idling in the hwmod code.

Regards,

Tony
