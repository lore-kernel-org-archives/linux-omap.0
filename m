From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Add omap3_defconfig
Date: Mon, 30 Nov 2009 11:17:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3630@dbde02.ent.ti.com>
References: <20091130033434.GA8762@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60443 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbZK3Frs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 00:47:48 -0500
In-Reply-To: <20091130033434.GA8762@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Olof Johansson wrote:

> Having one combined defconfig that is the superset of the individual
> defconfigs for OMAP3 platforms is useful for easily finding build
> errors. Not to mention convenient as a base if you want to boot several
> platforms with a single kernel image.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> ---
> 
> Tony, I noticed linux-next doesn't build many of the OMAP defconfigs,
> and a handful of them won't build to date. I suggest adding this config,
> and I'll as Stephen Rothwell to add it as one of the configs that are
> tested (and build errors reported) for every release.
> 
> He's reluctant to add too many individual configs since it adds time to
> each cycle, but one more can surely be acceptable.
> 

Good idea. Kevin does something similar with the pm branch. There's
an omap3_pm_defconfig.

A few minor comments below.

> 
> -Olof
> 
<snip>

> +CONFIG_USER_SCHED=y
> +# CONFIG_CGROUP_SCHED is not set
> +# CONFIG_CGROUPS is not set
> +CONFIG_SYSFS_DEPRECATED=y
> +CONFIG_SYSFS_DEPRECATED_V2=y

Would you consider getting rid of these two?
There was a patch recently to remove these from the
other omap defconfigs, so this would be one inconsistency
between them.



<snip>

> +# Miscellaneous USB options
> +#
> +CONFIG_USB_DEVICEFS=y
> +CONFIG_USB_DEVICE_CLASS=y
> +# CONFIG_USB_DYNAMIC_MINORS is not set
> +CONFIG_USB_SUSPEND=y
> +CONFIG_USB_OTG=y
> +CONFIG_USB_OTG_WHITELIST=y
> +CONFIG_USB_OTG_BLACKLIST_HUB=y

This removes the ability to connect all devices to MUSB
in host mode. (Most flash drives would not be on the
whitelist). Also, blacklisting hubs means you can't use
an external hub either - which is commonly used with
beagle and other similar boards.


<snip>

> +# OMAP 343x high speed USB support
> +#
> +# CONFIG_USB_MUSB_HOST is not set
> +# CONFIG_USB_MUSB_PERIPHERAL is not set
> +CONFIG_USB_MUSB_OTG=y
> +CONFIG_USB_GADGET_MUSB_HDRC=y
> +CONFIG_USB_MUSB_HDRC_HCD=y
> +CONFIG_MUSB_PIO_ONLY=y

And this would remove the MUSB DMA support on these boards.
I think you should make this n. It's always possible to
disable dma by adding a parameter "musb_hdrc.use_dma=n" to
the kernel command line


- Anand
