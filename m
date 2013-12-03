From: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/7] usb: dwc3: adapt dwc3 core to use Generic PHY
 Framework
Date: Tue, 3 Dec 2013 13:59:27 +0200
Message-ID: <20131203115927.GD26423@xps8300>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381866857-3861-3-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On Wed, Oct 16, 2013 at 01:24:12AM +0530, Kishon Vijay Abraham I wrote:
> +	count = of_property_match_string(node, "phy-names", "usb2-phy");
> +	if (count >= 0 || (pdata && pdata->usb2_generic_phy)) {
> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> +		if (IS_ERR(dwc->usb2_generic_phy)) {
> +			dev_err(dev, "no usb2 phy configured yet");
> +			return PTR_ERR(dwc->usb2_generic_phy);
> +		}
> +		dwc->usb2_phy = NULL;
> +	}
> +
> +	count = of_property_match_string(node, "phy-names", "usb3-phy");
> +	if (count >= 0 || (pdata && pdata->usb3_generic_phy)) {
> +		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> +		if (IS_ERR(dwc->usb3_generic_phy)) {
> +			dev_err(dev, "no usb3 phy configured yet");
> +			return PTR_ERR(dwc->usb3_generic_phy);
> +		}
> +		dwc->usb3_phy = NULL;
> +	}

Is there some specific reason for these checks? The driver should not
need to care about the platform (DT, ACPI, platform based).

Just get the phys and check the return value. In case ERR_PTR(-ENODEV)
leave the phy as NULL and let the driver continue normally. With other
errors you make the dwc3 probe fail.

Thanks,

-- 
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
