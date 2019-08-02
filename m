From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
Date: Fri, 2 Aug 2019 16:25:13 +0900
Message-ID: <20190802072513.GA30522@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-2-david@lechnology.com>
 <20190727204836.1514265d@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190727204836.1514265d@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jul 27, 2019 at 08:48:36PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Jul 2019 10:45:35 -0500
> David Lechner <david@lechnology.com> wrote:
> 
> > This documents device tree binding for the Texas Instruments Enhanced
> > Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> > 
> > Signed-off-by: David Lechner <david@lechnology.com>
> 
> Up to William given it is a counter binding, (unless Rob overrules)
> but new bindings are generally preferred as yaml.
> 
> Content looks fine to me.
> 
> Thanks,
> 
> Jonathan

Rob,

Would you prefer these bindings as yaml, or shall I accept them as they
are now?

William Breathitt Gray

> 
> > ---
> >  .../devicetree/bindings/counter/ti-eqep.txt    | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.txt b/Documentation/devicetree/bindings/counter/ti-eqep.txt
> > new file mode 100644
> > index 000000000000..fbcebc2c2cc2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/counter/ti-eqep.txt
> > @@ -0,0 +1,18 @@
> > +Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
> > +
> > +Required properties:
> > +- compatible:		Must be "ti,am3352-eqep".
> > +- reg:			Physical base address and size of the registers map.
> > +- clocks:		Handle to the PWM's functional clock.
> > +- clock-names:		Must be "fck".
> > +- interrupts:		Handle to the eQEP event interrupt
> > +
> > +Example:
> > +
> > +	eqep0: eqep@180 {
> > +		compatible = "ti,am3352-eqep";
> > +		reg = <0x180 0x80>;
> > +		clocks = <&l4ls_gclk>;
> > +		clock-names = "fck";
> > +		interrupts = <79>;
> > +	};
> 
