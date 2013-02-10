From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH RFC 1/7] platform: add a device node
Date: Sun, 10 Feb 2013 02:49:21 +0100
Message-ID: <5116FCA1.40703@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk> <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk> <20130210010246.GA1455@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40414 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760903Ab3BJBtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 20:49:25 -0500
In-Reply-To: <20130210010246.GA1455@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>

Hi Greg,

Thanks a lot for your feedback.

On 02/10/2013 02:02 AM, Greg Kroah-Hartman wrote:
> On Sat, Feb 09, 2013 at 09:44:25PM +0100, Javier Martinez Canillas wrote:
>> When using Device Trees, it is necessary to associate a
>> device node with a platform device.
>> 
>> Usually this device node has to used in the device probe
>> function (e.g: to initizalize the pinctrl pads assocaited
>> with the device).
>> 
>> So, platform code needs to pass a device node as a platform
>> device info to the platform device registration function.
> 
> Really?  We don't already have enough other pointers in the platform
> device structure that we need another one?
>

I knew this would be controversial and that's why I didn't mean it to be a patch
but a RFC :)

The problem basically is that you have to associate the platform device with its
corresponding DT device node because it can be used in the driver probe function.

But you can't do this before calling platform_device_register_resndata() since
the platform_device has not been allocated yet and you can't do it after since
by then the driver probe function has been executed already.

You could certainly pass the device node as a platform device resource by for
example storing the dev node pointer in the struct resource .start member or by
adding it to the structure (struct smsc911x_platform_config in this case) that
gets copied to the struct platform_device_info void *data.

Then in the driver probe function you could get the device node from either the
platform_data or a dev->resource.

But I expect most users of platform_device_register_resndata() will have a
similar issue as more and more platform drivers are migrated to DT.

So, to avoid each driver to do the same (encode and decode the DT device node
using platform_data or a device resource) I thought that it could make sense to
add yet another pointer to the struct platform_device_info structure and set:

pdev->dev.of_node = pdevinfo->of_node

inside platform_device_register_full().

> I don't buy it, sorry.  Any reason you didn't run this by Grant as well?
> 

No reason at all, it is just me being goofy. I thought that Grant was cc'ed
already and I just realized that he wasn't. cc'ing him as well.

> greg k-h
> 

Thanks a lot and best regards,
Javier
