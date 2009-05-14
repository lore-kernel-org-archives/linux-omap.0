From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]RESEND:OMAP3:configs: rename sdp and ldp defconfig
Date: Thu, 14 May 2009 11:05:36 -0700
Message-ID: <20090514180536.GO5593@atomide.com>
References: <1240433242-29386-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62373 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbZENSFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 14:05:38 -0400
Content-Disposition: inline
In-Reply-To: <1240433242-29386-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [090422 13:47]:
> Rename the 3430sdp and ldp defconfig to make
> names to make them collected with omap3 filenames

Well we already have products that just have the product
name in the defconfig, like overo_defconfig and n770_defconfig.

I think we have more urgent patches to get to the mainline tree,
so let's put this on hold. BTW, if you need to find out omap3
boards, just $ grep CONFIG_ARCH_OMAP3 arch/arm/configs/

Regards,

Tony
 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  ...p_3430sdp_defconfig => omap3_3430sdp_defconfig} |    0 
>  .../{omap_ldp_defconfig => omap3_zoom1_defconfig}  |    0 
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename arch/arm/configs/{omap_3430sdp_defconfig => omap3_3430sdp_defconfig} (100%)
>  rename arch/arm/configs/{omap_ldp_defconfig => omap3_zoom1_defconfig} (100%)
> 
> diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap3_3430sdp_defconfig
> similarity index 100%
> rename from arch/arm/configs/omap_3430sdp_defconfig
> rename to arch/arm/configs/omap3_3430sdp_defconfig
> diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap3_zoom1_defconfig
> similarity index 100%
> rename from arch/arm/configs/omap_ldp_defconfig
> rename to arch/arm/configs/omap3_zoom1_defconfig
> -- 
> 1.5.4.3
> 
