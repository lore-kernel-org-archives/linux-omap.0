From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 0/4] AM3517: MMC: Add support for HSMMC
Date: Thu, 26 Nov 2009 20:37:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3296@dbde02.ent.ti.com>
References: <1259000697-32175-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52014 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbZKZPH0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 10:07:26 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAQF7U7k024577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 09:07:32 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAQF7TCt016223
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 20:37:30 +0530 (IST)
In-Reply-To: <1259000697-32175-1-git-send-email-anuj.aggarwal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Aggarwal, Anuj
> Sent: Monday, November 23, 2009 11:55 PM
> To: linux-omap@vger.kernel.org
> Cc: Aggarwal, Anuj
> Subject: [PATCH 0/4] AM3517: MMC: Add support for HSMMC
> 
> This patch series adds support for HSMMC for AM3517 platform.
> It also enables the HSMMC driver in the AM3517 defconfig.
> 
> Anuj Aggarwal (4):
>   AM3517: MMC: Add low-level init code for HSMMC controller
>   AM3517: MMC: Modifying board-evm file to add mmc_init
>   AM3517: MMC: Modifying Makefile to enable MMC init
>   AM3517: MMC: Make HSMMC driver built-in
> 
>  arch/arm/configs/am3517_evm_defconfig |   21 +++-
>  arch/arm/mach-omap2/Makefile          |    3 +-
>  arch/arm/mach-omap2/board-am3517evm.c |   22 +++
>  arch/arm/mach-omap2/mmc-am3517evm.c   |  267
> +++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/mmc-am3517evm.h   |   22 +++
>  5 files changed, 333 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/mmc-am3517evm.c
>  create mode 100644 arch/arm/mach-omap2/mmc-am3517evm.h

[Aggarwal, Anuj] Any comments on the patch series?
