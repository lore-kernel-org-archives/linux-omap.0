From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/13] mfd: twl-core: Add initial DT support for twl4030/twl6030
Date: Thu, 01 Sep 2011 20:27:30 +0200
Message-ID: <4690440.pddZTpGgxd@wuerfel>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com> <1314897689-17791-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61058 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087Ab1IAS1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 14:27:34 -0400
In-Reply-To: <1314897689-17791-5-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>, grant.likely@secretlab.ca, tony@atomide.com, manjugk@ti.com, devicetree-discuss@lists.ozlabs.org, Graeme Gregory <gg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

On Thursday 01 September 2011 19:21:20 Benoit Cousson wrote:
> +#ifdef CONFIG_OF
> +#define MODALIAS_SIZE 32
> +
> +static int add_of_children(struct i2c_client *client, unsigned long features)
> +{
> +       u32 reg;
> +       struct device *child, *dev = &client->dev;
> +       struct device_node *node, *parent = client->dev.of_node;
> +       int irq;
> +       char alias[MODALIAS_SIZE];
> +
> +       for_each_child_of_node(parent, node) {
> +               if (of_property_read_u32(node, "reg", &reg)) {
> +                       dev_err(dev, "%s(): invalid reg on %s\n", __func__,
> +                               node->full_name);
> +                       continue;
> +               }
> +

Have you tried just calling calling of_platform_bus_probe on the
parent? If all child devices are in the device tree, I think that 
should work, too. It probably requires some tweaking in the
child drivers though.

	Arnd
