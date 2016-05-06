From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] regulator: lp873x: Add support for lp873x PMIC
 regulators
Date: Fri, 6 May 2016 10:13:24 +0530
Message-ID: <572C20EC.7000706@ti.com>
References: <1462425040-18566-1-git-send-email-j-keerthy@ti.com>
 <1462425040-18566-4-git-send-email-j-keerthy@ti.com>
 <20160505153820.GF6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160505153820.GF6292-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,


On Thursday 05 May 2016 09:08 PM, Mark Brown wrote:
> On Thu, May 05, 2016 at 10:40:40AM +0530, Keerthy wrote:
>
>> +static const struct of_device_id of_lp873x_match_tbl[] = {
>> +	{ .compatible = "ti,lp8733-regulators",},
>> +	{ .compatible = "ti,lp8732-regulators",},
>> +	{ .compatible = "ti,lp873x-regulators",},
>> +	{},
>> +};
>
> There should be no need for compatible strings here, we already know
> what device this is from the parent.  The way we split drivers up for
> Linux is something that's internal to Linux and shouldn't be in the
> device tree.  If we do have explicit compatible strings then they should
> (as always) be specific to a device, no wildcards.

Thanks for the review.

I am using of_platform_populate function in the mfd driver to create 
platform devices for the child nodes, in my case regulators.

of_platform_populate in turn calls on to of_platform_bus_create which 
mandates compatible properties. It quietly skips device creation if 
there are no compatible properties.

When i enabled a debug print, i see this:
skipping /ocp/i2c@48070000/lp8732@61/regulators, no compatible prop
Hence i kept the compatible properties.

The driver supports two variants of LP873x family:

1) LP8732
2) LP8733

I will knock off the ti,lp873x-regulators compatible which is more 
generic/wildcard entry.

Let me know if this approach is fine.

>
> Otherwise this looks sensible.
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
