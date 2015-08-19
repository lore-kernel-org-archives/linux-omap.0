From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER
 from devm_usb_get_phy_by_node
Date: Wed, 19 Aug 2015 10:28:32 +1000
Message-ID: <20150819102832.29a5059f@home.neil.brown.name>
References: <20150730001113.4012.18086.stgit@noble>
	<20150730001124.4012.31980.stgit@noble>
	<20150818080758.GG4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150818080758.GG4215@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 18 Aug 2015 01:07:58 -0700 Tony Lindgren <tony@atomide.com>
wrote:

> * NeilBrown <neil@brown.name> [150729 17:29]:
> > Now that twl4030_bci_probe can safely return -EPROBE_DEFER,
> > do so when devm_usb_get_phy_by_node returns that error.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  drivers/power/twl4030_charger.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> > index 045238370d3f..ffc123fb7158 100644
> > --- a/drivers/power/twl4030_charger.c
> > +++ b/drivers/power/twl4030_charger.c
> > @@ -636,9 +636,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
> >  
> >  		phynode = of_find_compatible_node(bci->dev->of_node->parent,
> >  						  NULL, "ti,twl4030-usb");
> > -		if (phynode)
> > +		if (phynode) {
> >  			bci->transceiver = devm_usb_get_phy_by_node(
> >  				bci->dev, phynode, &bci->usb_nb);
> > +			if (IS_ERR(bci->transceiver) &&
> > +			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +		}
> >  	}
> 
> Neil, the return with -EPROBE_DEFER here causes flakeyness booting
> for me somehow at least on my logicpd-torpedo-37xx-devkit using
> omap2plus_defconfig.
> 
> It seems that the twl4030_bci_probe keeps looping or something about
> 1/3 of the boots and that probably prevents the other twl modules
> from loading? Reverting this patch alone seems to fix the issue.
> 
> I don't think I have a battery wired on this board the USB is wired
> the same way as on beagle-xm. So I'd assume also flakeyness on beagle
> xm with this patch.
> 
> Regards,
> 
> Tony

What dts file are you using?
I'm guessing that it doesn't have something like:

&usb_otg_hs {
        interface-type = <0>;
        usb-phy = <&usb2_phy>;
        phys = <&usb2_phy>;
        phy-names = "usb2-phy";
        mode = <3>;
        power = <50>;
};

? i.e. with a usb-phy=<&usb2_phy> ?

What if you add

&usb2_phy {
 status = "disabled";
}

to your dts file?

Should the 'status' be disabled in twl4030.dtsi, and then marked OK in
any dts that uses it?  I'm not at all clear on how 'status' is meant to
be used.

Thanks,
NeilBrown

