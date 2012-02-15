From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Wed, 15 Feb 2012 14:04:01 +0100
Message-ID: <4F3BAD41.1020102@ti.com>
References: <1328854552-30714-1-git-send-email-archit@ti.com>  <1329220678.1845.68.camel@deskari>  <4F3A5A5D.4020906@ti.com>  <1329225311.1845.109.camel@deskari> <4F3A61EF.4030803@ti.com>  <4F3A809E.3070508@ti.com> <4F3B9E8F.1020002@ti.com> <4F3BA6A2.60604@ti.com> <1329310317.1892.60.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50489 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754566Ab2BONEL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 08:04:11 -0500
In-Reply-To: <1329310317.1892.60.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

+ Kevin

On 2/15/2012 1:51 PM, Tomi Valkeinen wrote:
> On Wed, 2012-02-15 at 13:35 +0100, Cousson, Benoit wrote:
>
>> I think that changing the device creation to change the dev->parent
>> should be pretty straightforward.
>
> That's not possible with the current kernel, right?
>
> We are now using omap_device_build() (in arch/arm/mach-omap2/display.c)
> to build the dss devices. Looking at the omap_device.c, the parent will
> always forcibly set to omap_device_parent. It'd be nice to be able to
> construct the device child-parent relationship the same way with both DT
> and non-DT cases.

I guess this should not be needed anymore since now the whole PM runtime 
stuff is handled using pm_domain.

int omap_device_register(struct platform_device *pdev)
{
	pr_debug("omap_device: %s: registering\n", pdev->name);

	pdev->dev.parent = &omap_device_parent;
	pdev->dev.pm_domain = &omap_device_pm_domain;
	return platform_device_add(pdev);
}


Kevin,

Do we still need to set the dev.parent to omap_device_parent?
I guess the default &platform_bus parent is good enough and potentially 
the DSS children should be able to overwrite that.

> Or can I create only the dss_core with omap_device_build(), and create
> the rest normally with platform device functions, and make dss_core the
> parent of the rest? But are the hwmods then handled correctly?

You can, the only issue if you create a regular platform device is that 
you will miss the automatic pm_runtime support along with the hwmod 
device creation mechanism + clock / PM.

I think we can add an extra parameter to allow changing the omap_device 
parent during omap_device_build.

Regards,
Benoit
