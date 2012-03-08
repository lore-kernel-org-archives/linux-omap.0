From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 16/21] OMAPDSS: handle output-driver reg/unreg more dynamically
Date: Thu, 8 Mar 2012 14:52:42 +0530
Message-ID: <4F587A62.3020202@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>  <1331124290-6285-17-git-send-email-tomi.valkeinen@ti.com>  <4F586EFD.1020208@ti.com> <1331196364.2354.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab2CHJW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 04:22:59 -0500
In-Reply-To: <1331196364.2354.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 08 March 2012 02:16 PM, Tomi Valkeinen wrote:
> On Thu, 2012-03-08 at 14:04 +0530, Archit Taneja wrote:
>> On Wednesday 07 March 2012 06:14 PM, Tomi Valkeinen wrote:
>
>>> -	r = hdmi_init_platform_driver();
>>> -	if (r) {
>>> -		DSSERR("Failed to initialize hdmi\n");
>>> -		goto err_hdmi;
>>> +	/*
>>> +	 * It's ok if the output-driver register fails. It happens, for example,
>>> +	 * when there is no output-device (e.g. SDI for OMAP4).
>>> +	 */
>>
>> Suppose we do a omap2plus_defconfig, CONFIG_OMAP2_DSS_SDI would be
>> selected, and sdi.c would be built, if we boot on OMAP4, why would a sdi
>> driver register cause a failure? Wouldn't the sdi driver just get
>> registered, and wait till eternity for the corresponding sdi platform
>> device to get registered?
>
> No. Well, yes.
>
> Currently we use platform_driver_register() to register the drivers, and
> it does just what you described. But a few patches later I change
> platform_driver_register() to platform_driver_probe(), which will return
> ENODEV if there are no matching devices for the driver.
>
> I originally had the platform_driver_probe() patch before this patch,
> and thus the comment above made sense. Now the patch is after this
> patch, so the comment is not exactly right until the probe patch is also
> applied.

Oh okay. But the comment after the patch set still says "It's ok if the 
output-driver register fails.", we could change it to "It's ok if the 
output-driver probe fails."

>
> The point with platform_driver_probe() is that it can be used with
> non-removable devices which are created at boot time, like the DSS
> components. With platform_driver_probe() the probe function is called
> only at that one time, and never afterwards. So probe can be in __init
> section, and thrown away after init.

So platform_driver_probe() is like a driver_register() + probe().

Okay, in our case, all the devices are created at boot time, and if 
omapdss were a module, the probes would have been thrown away after 
module_init(), right?

>
> One side effect of using platform_driver_probe() is that it returns
> ENODEV is there are no devices. In a simple module, the error can be
> then returned from module_init, thus causing the whole module to be
> unloaded. Our case is a bit more complex as we have multiple drivers in
> the same module.
>
> A downside with that is that we don't really know if the ENODEV error
> happened because there were no devices (which is ok), or if it came from
> probe function (which is not so ok). However, I thought that it doesn't
> matter if an output driver has failed. We can still continue with the
> other output drivers just fine.

If we ensure that none of our probes return ENODEV(even though it may 
make sense to return it if a func within probe fails), we could 
differentiate between the 2 cases, right?

>
> Actually, there is a small problem. If, for example, DSI driver fails to
> load, and DPI driver tries to use DSI PLL...

If we could differentiate between an error occuring because the device 
doesn't exist and an error occuring because the probe failed, we could 
bail out if any of the probes fail, right?

Archit

>
>   Tomi
>

