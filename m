From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] Device tree binding for Avago APDS990X light sensor
Date: Fri, 5 Jan 2018 10:01:37 -0600
Message-ID: <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180102124450.GA18659@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 02, 2018 at 01:44:51PM +0100, Pavel Machek wrote:
> From: Filip Matijević <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This prepares binding for light sensor used in Nokia N9.

"dt-bindings: ..." is the preferred subject prefix.

> 
> Signed-off-by: Filip Matijević <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> 
> diff --git a/Documentation/devicetree/bindings/misc/avago-apds990x.txt b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
> new file mode 100644
> index 0000000..480c0b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt

Put this with other light sensors whether you use IIO or not:

bindings/iio/light/

> @@ -0,0 +1,41 @@
> +Avago APDS990X driver

Bindings aren't drivers.

> +
> +https://docs.broadcom.com/docs/AV02-2867EN
> +
> +Required properties:
> +- compatible: "avago,apds990x"
> +- reg: address on the I2C bus
> +- interrupts: external interrupt line number
> +- vdd-supply: power supply for VDD
> +- vled-supply: power supply for LEDA
> +- avago,ga: Glass attenuation

We already have "upisemi,glass-coef". Can we align on something common.

> +- avago,cf1: Clear channel factor 1
> +- avago,irf1: IR channel factor 1
> +- avago,cf2: Clear channel factor 2
> +- avago,irf2: IR channel factor 2

Perhaps 2 properties with 2 cells for factor 1 and 2.

> +- avago,df: Device factor

Units/range for all these?

> +- avago,pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values

Don't we have standard current property for LEDs?

> +- avago,ppcount: Proximity pulse count

Is this standard for prox sensors?

> +
> +Example (Nokia N9):
> +
> +	als_ps@39 {

light-sensor@39

> +		compatible = "avago,apds990x";
> +		reg = <0x39>;
> +
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <19 (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW)>; /* gpio_83 */
> +
> +		vdd-supply = <&vaux1>;
> +		vled-supply = <&vbat>;
> +
> +		avago,ga	= <168834>;
> +		avago,cf1	= <4096>;
> +		avago,irf1	= <7824>;
> +		avago,cf2	= <877>;
> +		avago,irf2	= <1575>;
> +		avago,df	= <52>;
> +
> +		avago,pdrive	= <0x2>; /* APDS_IRLED_CURR_25mA */
> +		avago,ppcount	= <5>;
> +	};
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
