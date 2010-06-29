From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: Boot fail on OMAP3430SDP
Date: Tue, 29 Jun 2010 11:06:14 -0500
Message-ID: <A24693684029E5489D1D202277BE8944562E8FB4@dlee02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305A40F8A@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870305A40FBB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627Ab0F2QGS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 12:06:18 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5TG6IeL021475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 11:06:18 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5TG6Hnq013770
	for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 11:06:17 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5TG6HSB020056
	for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 11:06:17 -0500 (CDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305A40FBB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Vishwa,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sripathy, Vishwanath
> Sent: Tuesday, June 29, 2010 9:15 AM
> To: linux-omap@vger.kernel.org
> Subject: RE: Boot fail on OMAP3430SDP
> 
> Here is the log from Early printk.
> 

<snip>

> Could not get gpios_ick
> Could not get gpios_fck

Probably Tony will be the best to answer this, but... This code shouldn't get executed I think (the one producing above prints)..

Above clocks are declared for omap2 only (in arch/arm/mach-omap2/clock24[20,30]_data.c), and even this clk_get calls are
inside of a supposedly omap2 only execution in arch/arm/plat-omap/gpio.c:

static int __init _omap_gpio_init(void)
{
...
...
#if defined(CONFIG_ARCH_OMAP2)
	if (cpu_class_is_omap2()) {
		gpio_ick = clk_get(NULL, "gpios_ick");
		if (IS_ERR(gpio_ick))
			printk("Could not get gpios_ick\n");
		else
			clk_enable(gpio_ick);
		gpio_fck = clk_get(NULL, "gpios_fck");
		if (IS_ERR(gpio_fck))
			printk("Could not get gpios_fck\n");
		else
			clk_enable(gpio_fck);

		/*
		 * On 2430 & 3430 GPIO 5 uses CORE L4 ICLK
		 */
#if defined(CONFIG_ARCH_OMAP2430)
		if (cpu_is_omap2430()) {
			gpio5_ick = clk_get(NULL, "gpio5_ick");
			if (IS_ERR(gpio5_ick))
				printk("Could not get gpio5_ick\n");
			else
				clk_enable(gpio5_ick);
			gpio5_fck = clk_get(NULL, "gpio5_fck");
			if (IS_ERR(gpio5_fck))
				printk("Could not get gpio5_fck\n");
			else
				clk_enable(gpio5_fck);
		}
#endif
	}
#endif
...
}

So, I guess your board is trying to get initialized as omap2 somehow...

Regards,
Sergio

<snip>

