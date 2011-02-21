From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 5/6] omap4: Initialise the l3 device with the hwmod data.
Date: Mon, 21 Feb 2011 19:10:50 +0100
Message-ID: <4D62AAAA.40104@ti.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com> <1298295990-1070-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55403 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab1BUSKx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 13:10:53 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LIAqno026080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 12:10:53 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1LIAqRh010179
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 12:10:52 -0600 (CST)
In-Reply-To: <1298295990-1070-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "R, Sricharan" <r.sricharan@ti.com>

On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
> From: sricharan<r.sricharan@ti.com>
>
> The l3 interconnect device is build with all the data required
> to handle the error logging. The data is extracted from the
> hwmod data base.
>
> Signed-off-by: sricharan<r.sricharan@ti.com>
> Signed-off-by: sricharan<r.sricharan@ti.com>
> Tested-by: sricharan<r.sricharan@ti.com>

Mmm, I'm not sure the tested-by is meaningfull in your case, since you 
wrote the code and so everybody will assume you tested it.
One s-o-b should be probably enough.

> Cc: Benoit Cousson<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/devices.c |   23 +++++++++++++++++++++++
>   1 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 2d46f55..25fa2ad 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -57,6 +57,29 @@ static int __init omap3_l3_init(void)
>   }
>   postcore_initcall(omap3_l3_init);
>
> +static int __init omap4_l3_init(void)
> +{
> +	int l;
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +	char oh_name[12];
> +
> +	l = snprintf(oh_name, 12, "l3_main_1");
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +
> +	if (!oh)
> +		pr_err("could not look up %s\n", oh_name);
> +
> +	od = omap_device_build("omap4-l3-interconnect", 0, oh, NULL,

In order to stick to the OMAP device naming convention and to have 
something not dependent of the chip version, I think we'd better name 
the device like that: "omap_l3_noc". Since it is a Arteris "Network On 
Chip" on OMAP4. We will not have to change it for OMAP5 then.
On OMAP3 the name can then be "omap_l3_smx" for the Sonics MX interconnect.

Please note that the L4 is in both case a Sonics 3220. But I don't think 
the L4 is managed by this series.
Maybe the driver file name should be renamed accordingly.

Regards,
Benoit

> +						     0, NULL, 0, 0);
> +
> +	WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
> +
> +	return PTR_ERR(od);
> +}
> +postcore_initcall(omap4_l3_init);
> +
>   #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
>
>   static struct resource cam_resources[] = {

