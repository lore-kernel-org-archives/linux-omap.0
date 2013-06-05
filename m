From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource flags
Date: Thu, 06 Jun 2013 00:34:22 +0100
Message-ID: <20130605233422.3D6DE3E10E4@localhost>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:61399 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab3FEXe0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jun 2013 19:34:26 -0400
Received: by mail-ea0-f175.google.com with SMTP id d15so1820761eaj.34
        for <linux-omap@vger.kernel.org>; Wed, 05 Jun 2013 16:34:25 -0700 (PDT)
In-Reply-To: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Fri,  5 Apr 2013 09:48:08 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
[...]
> irq_of_parse_and_map() calls to irq_create_of_mapping() which calls to
> the correct xlate function handler according to "#interrupt-cells"
> (irq_domain_xlate_onecell or irq_domain_xlate_twocell) and to
> irq_set_irq_type() to set the IRQ type.
> 
> But the type is never returned so it can't be saved on the IRQ struct
> resource flags member.
> 
> This means that drivers that need the IRQ type/level flags defined in
> the DT won't be able to get it.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
[...]
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 535cecf..98aec57 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -66,6 +66,10 @@ extern int of_irq_map_one(struct device_node *device, int index,
>  extern unsigned int irq_create_of_mapping(struct device_node *controller,
>  					  const u32 *intspec,
>  					  unsigned int intsize);
> +extern unsigned int irq_create_of_mapping_type(struct device_node *controller,
> +					       const u32 *intspec,
> +					       unsigned int intsize,
> +					       unsigned int *otype);

I count 11 users of irq_create_of_mapping(). That's a managable number
to update. Instead of creating a new function, please modify the
existing one and split it off into a separate patch.

Otherwise the patch looks fine to me.

g.

