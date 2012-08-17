From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Fri, 17 Aug 2012 09:51:00 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA9220D@DBDE01.ent.ti.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
 <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
 <20120814082911.GG11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA8F4CD@DBDE01.ent.ti.com>
 <20120817074934.GL11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA92062@DBDE01.ent.ti.com>
 <20120817084047.GN11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607Ab2HQJvM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 05:51:12 -0400
In-Reply-To: <20120817084047.GN11011@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Fri, Aug 17, 2012 at 14:10:47, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120817 01:22]:
> > On Fri, Aug 17, 2012 at 13:19:34, Tony Lindgren wrote:
> > > * Hiremath, Vaibhav <hvaibhav@ti.com> [120815 02:11]:
> > > > 
> > > > Somehow we have to have some mechanism to initialize " _mpu_rt_va" before 
> > > > core_init call, which will take DT resources and initialize accordingly.
> > > 
> > > That's for the device reset/idle? We should not do that in hwmod code
> > > except in late_initcall for unclaimed devices as discussed earlier. We
> > > discussed setting up the reset function in the device specific headers
> > > so both device and hwmod code can call them as needed.
> > 
> > May be I didn't understand your above statement, can you please elaborate 
> > more on "device specific header file"?
> 
> We should have the device drivers idle and reset the devices. But also
> hwmod may need to do that for the unclaimed devices for PM to work. 
> As the driver may not be even compiled in, the driver specific reset and
> idle functions should be static inline functions in the device specific
> header file so hwmod code can still call those.
>  

How about mapping the address of the devices?

Some more thoughts on the similar line on unclaimed devices -
As par of late_initcall(), traverse all the DTB nodes and for each node with 
"state = disabled", we can do something like,

Late_initcall()
	-> Traverse DTB nodes and check for "state = disabled"
		-> Read the "ti,hwmod" entry and get offsets like, sys_config 
		   and reset.
		-> Map the base address
		-> Enable the module/clock
		-> Reset the device
		-> Write to sysc register offset
		-> Disable the module/clock



> > Just to highlight, its not only during late_initcall, the _enable and _idle 
> > functions are getting executed as part of every runtime_pm_get\put_sync from 
> > the driver.
> 
> Right, so no need to initialize those until at driver probe time.
>  

Agreed.

> > Are you saying as part of late_initcall, we should initialize " _mpu_rt_va" 
> > of "struct omap_hwmod"???
> 
> I guess either at driver probe for the claimed devices, or at late_initcall
> for the unclaimeded devices.
> 
> > Also, as far unclaimed resources is concerned, somewhere you should have 
> > base addr of the device maintained, right? Currently, hwmod is maintaining 
> > this data and the execution goes something like,
> > 
> > Core_initcall()
> > 	-> _setup()
> > 		-> _setup_reset()
> > 		-> _idle()
> 
> For the DT only case also the unclaimed devices can from DT with
> status = "disabled". 
>  
> > Another biggest worry is, if I play here, it may break existing omap3/4 
> > Functionality, especially may impact from PM perspective. So I believe, we 
> > need to have something which adds/cleans-up things in stages.
> 
> It seems that we need three stages: Something early for the timers only,
> initialize most things during driver probe, then late_initcall for the
> unclaimed devices.
> 

Most likely yes, or it may even get into more stages.

At the current stage, I really think it would be really nice and beneficial 
for driver developers from the community if they get Linux Boot from 
linux-next/master branch. I have seen lot of community folks are struggling 
with it and they are blocked because we do not have booting kernel on 
BeagleBone.
They always end up patching kernel with HWMOD patch and submit the driver 
patches. So request to consider this cleanup as sequential patch on top of 
original HWMOD patch?


> > May be get rid of resource overwriting for AM33xx and OMAP5 alone as of 
> > now??
> 
> Sorry I don't follow this part, care to explain a little more?
> 

As per current implementation, we are using HWMOD information to fill the 
platform_device->resources. Even if you pass "reg" and "interrupt" property 
from DT, omap_device layer overwrites it with HWMOD data information.

So what I am trying to propose here is, avoid this overwrite and resources 
(address and interrupt) should strictly gets used from DT blob. Since AM33xx 
and OMAP5 devices are the new devices and supports DT boot only, we can 
implement it easily for them.

Only issue her is, DMA resources, I was going through some of the old email 
archives today, submitted by Benoit and later Jon, but I am still not sure 
how to pass dma_channel to driver as a resource.

Below logic works for me, I have tested it on both BeagleBone and AM37xEVM -

omap_device_alloc ()
{
	...

	res_count = omap_device_count_resources(od);
	if (res_count > pdev->num_resources) {
		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
	      if (!res)
      		goto oda_exit3;

		if (pdev->num_resources && pdev->resource) {
			omap_device_fill_dma_resources(od, res);
			memcpy(&res[pdev->num_resources], pdev->resource,
				sizeof(struct resource) * pdev->num_resources);
			} else {
				omap_device_fill_resources(od, res);
			}
	
		ret = platform_device_add_resources(pdev, res, res_count);
		kfree(res);
	}

	...
}

Thanks,
Vaibhav
