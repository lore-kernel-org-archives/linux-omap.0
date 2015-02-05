From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC/PATCH 2/2] of: allow for boolean flags to have value
Date: Thu, 5 Feb 2015 18:22:41 +0000
Message-ID: <20150205182240.GD20735@leverpostej>
References: <1423159266-25561-1-git-send-email-balbi@ti.com>
 <1423159266-25561-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423159266-25561-2-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 05, 2015 at 06:01:06PM +0000, Felipe Balbi wrote:
> allowing values to boolean flags lets us setup
> defaults on DTSI which can get disabled later
> at board DTS if, for whatever reason, board can't
> use that default.
> 
> One such example is DM81xx EVM where we can't use
> MUSB's multipoint feature even though SoC supports
> it. Something at the board level prevents us from
> using the feature.
> 
> Instead of removing "multipoint;" from DTSI and
> adding it to all board DTS just so we can remove
> it from our quirky board seems like overkill when
> we could just add:
> 
> 	multipoint = <0>;
> 
> to that quirky board's DTS.
> 
> Note that the description here is but one example
> and it's likely many others have faced something
> similar.
> 

While I appreciate that adding and removing properties in this way is
painful, I think that this must be dealt with at DTB compile-time rather
than kernel run-time.

There are codebases other than Linux which parse DTs, and not all
drivers call of_property_read_bool to parse boolean properties, an awful
lot still just check of_find_property. Additionally, some bindings
_explicitly_ state boolean properties are empty and have no value, which
this extension would break.

I think that this patch only adds to the inconsistency we currently
have, and given that, I would rather not have this extension to
of_property_read_bool.

Arguably of_proeprty_read_bool should warn if it encounters a non-empty
property.

Thanks,
Mark.

> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  include/linux/of.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 76c055b20fef..c5ee9320f237 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -792,14 +792,32 @@ static inline int of_property_read_u32(const struct device_node *np,
>   * @propname:	name of the property to be searched.
>   *
>   * Search for a property in a device node.
> - * Returns true if the property exist false otherwise.
> + * Returns true if the property exist and has a value greater than zero,
> + * fals otherwise.
>   */
>  static inline bool of_property_read_bool(const struct device_node *np,
>  					 const char *propname)
>  {
>  	struct property *prop = of_find_property(np, propname, NULL);
> +	int rc;
> +	u32 val;
>  
> -	return prop ? true : false;
> +	if (!prop)
> +		return false;
> +
> +	rc = of_property_read_u32(np, propname, &val);
> +
> +	/*
> +	 * if property doesn't have a value, or prop->length == 0 and
> +	 * we overflow, treat it as simple value-less flag.
> +	 */
> +	if (rc == -ENODATA || rc == -EOVERFLOW)
> +		return true;
> +	if (WARN(rc < 0, "failed to read '%s' value -> %d\n",
> +				propname, rc))
> +		return false;
> +
> +	return !!val;
>  }
>  
>  static inline int of_property_read_s32(const struct device_node *np,
> -- 
> 2.3.0-rc1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
