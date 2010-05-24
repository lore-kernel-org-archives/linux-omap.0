From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
Date: Sun, 23 May 2010 19:59:28 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BDF42DA@dlee03.ent.ti.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
 <1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58779 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614Ab0EXA7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 May 2010 20:59:36 -0400
In-Reply-To: <1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>

Felipe,


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Contreras
> Sent: Saturday, May 22, 2010 12:25 PM
> To: linux-omap
> Cc: Hiroshi Doyu; Kevin Hilman; Paul Walmsley; Ohad Ben-Cohen; Felipe
> Contreras
> Subject: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
> 
> Only OMAP3 would work.

-- This is good start. 
I will look into adding/verifying OMAP4 support. If any one already started this effort please inform.
 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_3xxx_data.c
> index ed60840..62b8fa8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -164,12 +164,57 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  };
> 

-- Probably this should form a new patch.


Thank you,
Best regards,
Hari
