From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap5-uevm: Add Palmas power button support
Date: Tue, 21 Jul 2015 04:04:10 -0700
Message-ID: <20150721110409.GD17550@atomide.com>
References: <omap5uevm_palmas>
 <1437426451-27372-1-git-send-email-aparnab@ti.com>
 <55AD60E5.60301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55AD60E5.60301-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Aparna Balasubramanian <aparnab-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [150720 14:00]:
> On 07/20/2015 04:07 PM, Aparna Balasubramanian wrote:
> > Palmas on OMAP5uevm has support for power button, so enable it.
> > 
> > Signed-off-by: Aparna Balasubramanian <aparnab-l0cyMroinI0@public.gmane.org>
> > ---
> > 
> > Based on kernel tag 4.2.0-rc1 and test result log is at
> > http://pastebin.ubuntu.com/11910178/
> > 
> >  arch/arm/boot/dts/omap5-uevm.dts |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> > index 275618f..3cc8f35 100644
> > --- a/arch/arm/boot/dts/omap5-uevm.dts
> > +++ b/arch/arm/boot/dts/omap5-uevm.dts
> > @@ -510,6 +510,13 @@
> >  				};
> >  			};
> >  		};
> > +
> > +		palmas_power_button: palmas_power_button {
> > +			compatible = "ti,palmas-pwrbutton";
> > +			interrupt-parent = <&palmas>;
> > +			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> > +			wakeup-source;
> > +		};
> >  	};
> >  
> >  	twl6040: twl@4b {
> > 
> 
> Tested (with evtest) and verified on v4.2-rc3
> 
> Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v4.3/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
