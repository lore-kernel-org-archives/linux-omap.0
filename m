From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Fri, 8 Feb 2013 17:45:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081744100.28008@utopia.booyaka.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com> <20130108203853.GB1876@animalcreek.com> <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com> <20130117222728.GA32446@animalcreek.com>
 <20130128191635.GA14158@animalcreek.com> <alpine.DEB.2.00.1302011722070.10853@utopia.booyaka.com> <20130201201824.GA6326@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50553 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946758Ab3BHRp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 12:45:58 -0500
In-Reply-To: <20130201201824.GA6326@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Mark,

just FYI, these patches caused several warnings from sparse:

> arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c:141:30: warning: 
symbol 'omap2xxx_sham_addrs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c:150:30: warning: 
symbol 'omap2xxx_aes_addrs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c:884:28: warning: 
symbol 'omap2_sham_mpu_irqs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c:889:28: warning: 
symbol 'omap2_sham_sdma_chs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c:927:28: warning: 
symbol 'omap2_aes_sdma_chs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_data.c:540:28: warning: symbol 
'am33xx_aes0_edma_reqs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_data.c:579:28: warning: symbol 
'am33xx_sha0_edma_reqs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:3564:28: warning: symbol 
'omap3_sham_mpu_irqs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:3569:28: warning: symbol 
'omap3_sham_sdma_reqs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:3574:19: warning: symbol 
'omap3xxx_sham_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:3630:28: warning: symbol 
'omap3_aes_sdma_reqs' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:3636:19: warning: symbol 
'omap3xxx_aes_hwmod' was not declared. Should it be static?


I've fixed them up here, but please don't forget to make sure that patches 
don't add any sparse warnings.  sparse info is here:

https://sparse.wiki.kernel.org/index.php/Main_Page

regards,

- Paul
