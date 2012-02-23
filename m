From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH] ARM: OMAP2: fix mailbox init code
Date: Thu, 23 Feb 2012 09:18:01 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317AD2B7@DBDE01.ent.ti.com>
References: <1329987215-28227-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43815 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab2BWJST convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 04:18:19 -0500
In-Reply-To: <1329987215-28227-1-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi Doyu <hdoyu@nvidia.com>

On Thu, Feb 23, 2012 at 14:23:35, Ohad Ben-Cohen wrote:
[...]
> 
> Which happens on CONFIG_ARCH_OMAP2 && !CONFIG_SOC_OMAP2420, due to
> missing omap2_mboxes declaration.
> 
[...]
>  
> -struct omap_mbox *omap2_mboxes[] = { &mbox_dsp_info, &mbox_iva_info, NULL };
> +#ifdef CONFIG_ARCH_OMAP2
> +struct omap_mbox *omap2_mboxes[] = {
> +	&mbox_dsp_info,
> +#ifdef CONFIG_SOC_OMAP2420
> +	&mbox_iva_info,
> +#endif
> +	NULL
> +};
>  #endif
>  
>  #if defined(CONFIG_ARCH_OMAP4)

Instead of adding more #ifs can they be completely removed please?
