From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
Date: Tue, 10 Jul 2012 01:41:08 -0700
Message-ID: <20120710084107.GO1122@atomide.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com>
 <20120627161745.GO3483@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA5C2C4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29400 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab2GJIlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 04:41:09 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5C2C4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120627 13:37]:
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -42,7 +42,14 @@
>  #define OMAP2_DEVICE_TYPE_GP           3
>  #define OMAP2_DEVICE_TYPE_BAD          4
> 
> +#ifdef CONFIG_ARCH_OMAP2PLUS
>  int omap_type(void);
> +#else
> +inline static int omap_type(void)
> +{
> +	/* Always return GP, since it is not being used anyway for omap1 */
> +	return OMAP2_DEVICE_TYPE_GP;
> +}
> +#endif
> 
>  /*
>   * omap_rev bits:

Just to follow-up on this, looks like we need to postpone this
for v3.7. While at it, we need to make sure all soc_is_omapxxxx()
are false by default.

What you're suggesting above would also depend on some MULTI_ARCH
option set if multiple ARM architectures are selected. Above patch
would only optimize things when ARCH_OMAP2PLUS alone is selected.

Regards,

Tony
