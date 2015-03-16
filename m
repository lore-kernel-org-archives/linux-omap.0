From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: am335x: Add DTS for ChiliSOM module
Date: Mon, 16 Mar 2015 13:50:09 -0700
Message-ID: <20150316205008.GB12397@atomide.com>
References: <1423493285-4231-1-git-send-email-lisovy@jablotron.cz>
 <1423493285-4231-2-git-send-email-lisovy@jablotron.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423493285-4231-2-git-send-email-lisovy-/jIuvo6cn7g68gdbZb/DoA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rostislav Lisovy <lisovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rostislav Lisovy <lisovy-/jIuvo6cn7g68gdbZb/DoA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rostislav Lisovy <lisovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150209 06:51]:
> Since this is a SOM (System on Module) that will be part
> of another embedded board (and can't really exist on its own)
> define it as a "dtsi" that will be included in the Device tree
> describing the whole system later on.
> 
> Hardware specification:
> * AM335x SoC
> * up to 512 MB RAM
> * NAND Flash (8x interface, cs0)
> * UART0
> * PMIC
> * I2C0 (for PMIC)
> * 1x Ethernet MAC

Applying all three into omap-for-v4.1/dt with one change
below.
 
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
> +
> +&gpmc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nandflash_pins>;
> +	ranges = <0 0 0x08000000 0x01000000>; /* CS0 0 @addr 0x08000000, size 0x01000000 */
> +	nand@0,0 {
> +		reg = <0 0 0x01000000>; /* CS0 */

I've changed this to say just:
		reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */

As for NAND the device has just one IO register. The 0x01000000
is the size of a minimum GPMC partition.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
