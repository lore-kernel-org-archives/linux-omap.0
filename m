From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: omap3: Fix Sharp LS037V7DW01 compatible
 string and envdd supply
Date: Tue, 12 Sep 2017 12:33:29 -0500
Message-ID: <20170912173329.GA13284@hope>
References: <20170903003816.5536-1-woods.technical@gmail.com>
 <20170912034659.13184-1-woods.technical@gmail.com>
 <20170912034659.13184-4-woods.technical@gmail.com>
 <20170912143444.GR5024@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170912143444.GR5024@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 12, 2017 at 07:34:46AM -0700, Tony Lindgren wrote:
> * Derald D. Woods <woods.technical@gmail.com> [170911 20:48]:
> > The Sharp panel driver and regulator are now selected properly. This
> > commit eliminates a dummy regulator assignment.
> > 
> > Signed-off-by: Derald D. Woods <woods.technical@gmail.com>
> > 
> > ---
> >  arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
> > index 157345bb8e79..15f73e5adfdf 100644
> > --- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
> > +++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
> > @@ -26,9 +26,10 @@
> >  	};
> >  
> >  	lcd0: display {
> > -		compatible = "sharp,ls037v7dw01";
> > +		compatible = "omapdss,sharp,ls037v7dw01";
> 
> Is this change needed? I think the driver automatically matches
> even with the "omapdss" part missing?
> 

I will check tonight. It is likely something I added when trying various
DSS Kconfig options. I will keep my configuration unchanged and remove
the compatible line change above. If it is just noise, I will send 'v3'
with just 'envdd' supply addition.

Derald

> If it's needed, can you please update the description for why
> it's needed.
> 
> Regards,
> 
> Tony
