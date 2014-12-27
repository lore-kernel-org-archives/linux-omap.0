From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
Date: Sat, 27 Dec 2014 20:58:25 +0100
Message-ID: <20141227195825.GF10007@amd>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419597294-21487-3-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pali Rohar <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri 2014-12-26 13:34:53, Sebastian Reichel wrote:
> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> which can be used to determine the SoCs temperature. This patch provides
> a DT based driver for the temperature sensor based on an older driver
> written by Peter De Schrijver for the Nokia N900 and N9.
> 
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/hwmon/Kconfig      |   8 ++
>  drivers/hwmon/Makefile     |   1 +
>  drivers/hwmon/omap3-temp.c | 307 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 316 insertions(+)
>  create mode 100644 drivers/hwmon/omap3-temp.c

When it hangs, it loops here:

do {
regmap_read(data->syscon, SYSCON_TEMP_REG,&temp_sensor_reg);
if ((temp_sensor_reg & eocz_mask) == level)
   return true;
printk("=");
}
while (ktime_us_delta(expire, ktime_get()) > 0);

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
