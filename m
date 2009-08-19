From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] arch: arm: omap: terminate ifndef
Date: Wed, 19 Aug 2009 17:04:43 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD1AD8FB@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com>
 <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40604 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbZHSLey convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 07:34:54 -0400
In-Reply-To: <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Wednesday, August 19, 2009 4:02 PM
> To: linux-omap@vger.kernel.org
> Cc: Felipe Balbi
> Subject: [PATCH] arch: arm: omap: terminate ifndef
> 
> There was a missing endif on cpu.h
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/plat-omap/include/mach/cpu.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
> b/arch/arm/plat-omap/include/mach/cpu.h
> index 61dbe90..7a5f9e8 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -422,3 +422,5 @@ IS_OMAP_TYPE(3430, 0x3430)
>  
>  int omap_chip_is(struct omap_chip_id oci);
>  void omap2_check_revision(void);
> +
> +#endif /* __ASM_ARCH_OMAP_CPU_H */

ACKed.
Have mentioned the same yesterday.

Best regards,
Sanjeev

> -- 
> 1.6.3.3.385.g60647
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 