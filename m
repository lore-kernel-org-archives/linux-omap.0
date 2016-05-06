From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] regulator: lp873x: Add support for lp873x PMIC
 regulators
Date: Fri, 6 May 2016 18:06:38 +0530
Message-ID: <572C8FD6.20702@ti.com>
References: <1462425040-18566-1-git-send-email-j-keerthy@ti.com>
 <1462425040-18566-4-git-send-email-j-keerthy@ti.com>
 <20160505153820.GF6292@sirena.org.uk> <572C20EC.7000706@ti.com>
 <20160506120206.GO6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160506120206.GO6292-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 06 May 2016 05:32 PM, Mark Brown wrote:
> On Fri, May 06, 2016 at 10:13:24AM +0530, Keerthy wrote:
>
>> I am using of_platform_populate function in the mfd driver to create
>> platform devices for the child nodes, in my case regulators.
>
>> of_platform_populate in turn calls on to of_platform_bus_create which
>> mandates compatible properties. It quietly skips device creation if there
>> are no compatible properties.
>
> You shouldn't be using that, you should just have a table of subdevices
> in the MFD.

Okay. I will send v2 with compatibles removed.

Thanks,
Keerthy

>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
