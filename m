From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 1/3] DT Binding for omap3 temperature sensor
Date: Fri, 26 Dec 2014 18:19:44 +0100
Message-ID: <20141226171944.GA24756@amd>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419597294-21487-2-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pali Rohar <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri 2014-12-26 13:34:52, Sebastian Reichel wrote:
> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> which can be used to determine the SoCs temperature. This provides a
> DT binding specification for the temperature monitor.
> 
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../bindings/hwmon/omap3-temperature.txt           | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> new file mode 100644
> index 0000000..99631ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> @@ -0,0 +1,25 @@
> +* OMAP3 temperature sensor
> +
> +The OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> +which can be used to determine the SoCs temperature.
> +
> +Requires node properties:
> +- compatible :	should contain one of
> +	- "ti,omap34xx-temperature-sensor" for OMAP34xx
> +	- "ti,omap36xx-temperature-sensor" for OMAP36xx
> +- syscon :	Should be a phandle to system configuration node which
> +		encompases the temperature register
> +- clocks :	Should contain 32KHz fclk clock specifier
> +- clock-names :	Should contain clock names
> +	- "fck" for the 32KHz fclk clock specifier

I don't quite get it. The temperature sensor is internal on the CPU,
right? Why do we need device tree to describe it? As soon as we have
CPU that is compatible to ti,omap3430, we know everything we need to
know, no?

> +Example for omap34xx:
> +
> +/ {
> +	temperature-sensor {
> +		compatible = "ti,omap34xx-temperature-sensor";
> +		syscon = <&omap3_scm_general>;
> +		clocks = <&ts_fck>;
> +		clock-names = "fck";
> +	};
> +};

Or is there something that depends on the board there? Or do we want
to do it like this to be consistent with existing bindings?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
