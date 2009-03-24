From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: How to test regulator driver?
Date: Tue, 24 Mar 2009 17:14:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEEA01@dbde02.ent.ti.com>
References: <20090309153250.GF13593@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54369 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759262AbZCXLpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 07:45:18 -0400
In-Reply-To: <20090309153250.GF13593@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, "Pillai, Manikandan" <mani.pillai@ti.com>

I am seriously confused on how to fetch the struct device * in my consumer driver, for an already registered regulator. I am planning to use this consumer driver as a part of my CPU freq/CPU idle framework but I don't know what to pass in regulator_get.

Should I register my regulator device as a platform_device as against an i2c_client device what I am having now? Other regulator drivers (drivers/regulator/twl4030-regulator.c, wm8400.c etc) are doing the same thing in their code. Using the current approach, I am facing difficulty in getting the struct device * for invoking the regulator_get()?

Otherwise, can I expose one function in my regulator driver which will return the appropriate struct device * when user calls it with a supply name string? This device pointer then will be used in my consumer driver while calling the regulator_get API?

Thanks and Regards,
Anuj Aggarwal
 
Platform Support Products
Texas Instruments Inc
Ph: +91-80-2509-9542
TI IP Ph: 509-9542
PSP Products RSS Feed PSP Product Announcements
 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Monday, March 09, 2009 9:03 PM
> To: Anuj Aggarwal
> Cc: Linux OMAP List
> Subject: Re: How to test regulator driver?
> 
> On Mon, Mar 09, 2009 at 08:32:55PM +0530, Anuj Aggarwal wrote:
> 
> > I want to test my regulator driver by writing a small kernel module.
> > But I am a little confused as what should be passed as the first
> > argument of regulator_get(). How would the kernel module know about
> > the device pointer that needs to be passed to the _get function?
> 
> regulator_get() takes the struct device for the consumer as an argument
> so it depends on what your consumer is.  For test purposes there's an
> existing virtual consumer driver in the tree which should hopefully save
> you having to write your own - it allows you to poke the settings from
> sysfs.  drivers/regulator/virtual.c
> 
> Questions like this that aren't OMAP-specific should really be asked on
> the relevant general list (in this case linux-kernel).
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

