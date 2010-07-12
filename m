From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC 3/7] OMAP: Introduce voltage domain pointer and device
 specific set rate and get rate in device opp structures.
Date: Mon, 12 Jul 2010 16:48:26 +0200
Message-ID: <20100712164826.7548cd09@surf>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
	<1278065909-32148-2-git-send-email-thara@ti.com>
	<1278065909-32148-3-git-send-email-thara@ti.com>
	<1278065909-32148-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.191.76.200]:60798 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0GLOsn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 10:48:43 -0400
In-Reply-To: <1278065909-32148-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com

Hello Thara,

On Fri,  2 Jul 2010 15:48:25 +0530
Thara Gopinath <thara@ti.com> wrote:

>  #include <plat/common.h>
>  
> @@ -38,21 +39,45 @@
>   */
>  struct omap_opp_def {
>  	char *hwmod_name;
> +	char *vdd_name;
>  
>  	unsigned long freq;
>  	unsigned long u_volt;
>  
> +	int (*set_rate)(struct device *dev, unsigned long rate);
> +	unsigned long (*get_rate) (struct device *dev);
> +
>  	bool enabled;
>  };

It looks strange to me that per-OPP methods are needed to set/get the
rate. These should only be needed at the device level, no ?

And indeed, in your patch 6/7, for every device, the same get/set rate
methods are used for all OPPs of a given device.

> +struct device_opp {
> +	struct list_head node;
> +	char *vdd_name;
> +
> +	struct omap_hwmod *oh;
> +	struct device *dev;
> +	struct omap_volt_domain *volt_domain;
> +
> +	struct list_head opp_list;
> +	u32 opp_count;
> +	u32 enabled_opp_count;
> +
> +	int (*set_rate)(struct device *dev, unsigned long rate);
> +	unsigned long (*get_rate) (struct device *dev);
> +};

I know this structure already exists, but do we really need a new
structure for this ? Couldn't these infos (OPP list, set/get rate
methods) be stored in an existing device-specific structure (omap_hwmod
for hardware-related things are omap_device for ~software-related
things) ?

For example, why aren't OPPs attached to the hwmod description of the
particular device ? These OPPs definitions really look like a
characteristic of a particular IP, don't they ?

Whatever choice is made, this structure probably needs a comment on top
of it explaining what it does, since the name isn't very obvious IMO.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
