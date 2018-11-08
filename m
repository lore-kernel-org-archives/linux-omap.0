From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65: Add pinctrl regions
Date: Thu, 8 Nov 2018 07:13:56 -0800
Message-ID: <20181108151356.GG56134@atomide.com>
References: <20181108112647.7205-1-vigneshr@ti.com>
 <20181108112647.7205-3-vigneshr@ti.com>
 <20181108134723.utbk7322xlqzjcfq@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181108134723.utbk7322xlqzjcfq@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [181108 13:48]:
> On 16:56-20181108, Vignesh R wrote:
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> > index 3d4bf369d030..873dca1d0813 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> > @@ -8,6 +8,7 @@
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/pinctrl/k3-am65.h>
> >  
> >  / {
> >  	model = "Texas Instruments K3 AM654 SoC";
> > -- 
> > 2.19.1
> > 
> 
> Where is this used? Could we mux the uart console that we are using?
> will be good to see an example of usage.

Yes please.

And please add the SoC specific macro for the pins in a format
that makes the pinconf and pinmux options separate parameters
for the macro where the usage becomes something like:

AM65X_IOPAD(0x1234, PIN_INPUT_PULLUP, 0)

The above  0 is just the mux mode number in the example.
So no more need to use MUX_MODE0 define to redefine a number
when set up that way :)

This will allow us to eventually take advantage of the
#pinctrl-cells = <2>  and not have to change all the dts files
and just change the macro.

I also added Linus Walleij to Cc as this might interest him
also.

Regards,

Tony
