From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Mon, 16 Mar 2015 22:05:32 +0100
Message-ID: <20150316210532.GA11441@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423088075-10025-4-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed 2015-02-04 23:14:32, Marek Belisko wrote:
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> new file mode 100644
> index 0000000..bb3580c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> @@ -0,0 +1,43 @@
> +twl4030_madc_battery
> +
> +Required properties:
> + - compatible : "ti,twl4030-madc-battery"
> + - capacity-uah : battery capacity in uAh

Could we make it capacity-uAh ?

> + - volt-to-capacity-charging-map : list of voltage(mV):level(%) values
> +	for charging calibration (see example)
> + - volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
> +	for discharging calibration (see example)

Would "mV-to-capacity..." be more accurate? Also, would it make sense
to introduce coefficients for temperature and discharge rate?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
