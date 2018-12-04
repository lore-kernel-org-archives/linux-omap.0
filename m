From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654
 SoCs
Date: Tue, 4 Dec 2018 09:52:33 +0000
Message-ID: <20181204095233.GT26661@dell>
References: <20181119094509.22542-1-vigneshr@ti.com>
 <4b42082c-462d-3d94-8ee9-6e7a61f57134@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4b42082c-462d-3d94-8ee9-6e7a61f57134@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 04 Dec 2018, Vignesh R wrote:

> Hi,
> 
> On 19/11/18 3:15 PM, Vignesh R wrote:
> > AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
> > handle AM654 SoCs. Also, it seems that existing compatible strings used
> > in the kernel DTs were never documented. So, document them now.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> 
> Gentle ping on this patch..

Don't do that.

If you think your patch has been forgotten, please submit a [RESEND].

> >  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> > index b1163bf97146..aad5e34965eb 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> > @@ -2,7 +2,12 @@
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  
> >  Required properties:
> > +- mfd
> > +	compatible: Should be
> > +		"ti,am3359-tscadc" for AM335x/AM437x SoCs
> > +		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
> >  - child "tsc"
> > +	compatible: Should be "ti,am3359-tsc".
> >  	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
> >  		  support on the platform.
> >  	ti,x-plate-resistance: X plate resistance
> > @@ -25,6 +30,9 @@ Required properties:
> >  			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> >  			XP  = 0, XN = 1, YP = 2, YN = 3.
> >  - child "adc"
> > +	compatible: Should be
> > +		    "ti,am3359-adc" for AM335x/AM437x SoCs
> > +		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
> >  	ti,adc-channels: List of analog inputs available for ADC.
> >  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> >  
> > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
