From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH usb-next v9 2/8] usb: add a flag to skip PHY initialization
 to struct usb_hcd
Date: Mon, 12 Feb 2018 10:15:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1802121013360.1411-100000@iolanthe.rowland.org>
References: <20180211210651.2046-3-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180211210651.2046-3-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, 11 Feb 2018, Martin Blumenstingl wrote:

> The USB HCD core driver parses the device-tree node for "phys" and
> "usb-phys" properties. It also manages the power state of these PHYs
> automatically.
> However, drivers may opt-out of this behavior by setting "phy" or
> "usb_phy" in struct usb_hcd to a non-null value. An example where this
> is required is the "Qualcomm USB2 controller", implemented by the
> chipidea driver. The hardware requires that the PHY is only powered on
> after the "reset completed" event from the controller is received.
> 
> A follow-up patch will allow the USB HCD core driver to manage more than
> one PHY. Add a new "bool skip_phy_initialization" field to struct
> usb_hcd so drivers can opt-out of any PHY management provided by the USB
> HCD core driver. The new field will be used in that patch as well.
> 
> This also updates the existing drivers so they use the new flag if they
> want to opt out of the PHY management provided by the USB HCD core
> driver. This means that for these drivers the new "multiple PHY"
> handling (which will be added in a follow-up patch) will be disabled as
> well.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---

> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -98,6 +98,12 @@ struct usb_hcd {
>  	 */
>  	const struct hc_driver	*driver;	/* hw-specific hooks */
>  
> +	/*
> +	 * do not manage the PHY state in the HCD core, instead let the driver
> +	 * handle this (for example if the PHY can only be turned on after a
> +	 * specific event)
> +	 */
> +	bool skip_phy_initialization;

Instead of declaring this as a bool at some random location in the
structure, it would be better to make this a bitflag along with the
other ones that get set at registration.  For example, it could come
right after the remove_phy flag.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
