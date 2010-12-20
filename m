From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT] pull request: DMA hwmod changes
Date: Mon, 20 Dec 2010 11:45:29 +0100
Message-ID: <4D0F33C9.40402@ti.com>
References: <20101219035948.GC15568@GLPP-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60062 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab0LTKpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:45:45 -0500
In-Reply-To: <20101219035948.GC15568@GLPP-machine>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sawant, Anand" <sawant@ti.com>

Hi Manju,

I still have 2 comments on the patch #6: OMAP4: hwmod data: add system DMA.

I'll sent them in a couple of minutes.

Regards,
Benoit

On 12/19/2010 4:59 AM, G, Manjunath Kondaiah wrote:
> Hi Tony,
> Please pull the following dma hwmod changes into linux omap master
> branch.
>
> This pull request includes
> v2[http://thread.gmane.org/gmane.linux.ports.arm.omap/48695]
> +
> paul's sidle mode comments incorporated
> +
> acks for patch 3 and 4.
>
> The final series is boot tested on:
> OMAP3530(Beagle)
> N800
> SDP2430
> OMAP4430SDP(ES2.1)
>
> Full testing is done once again for SDP2430 and logs can be accessed at:
> http://pastebin.com/aJZGjdar
>
> The following changes since commit
> 205e4d6e8d892176d791b77a974efe7f561ca4c3:
>
>    Merge branch 'for-next' (2010-12-17 19:32:47 -0800)
>
> are available in the git repository at:
>
>    git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git dma_hwmod
>
> Benoit Cousson (1):
>        OMAP4: hwmod data: add system DMA
>
> G, Manjunath Kondaiah (8):
>        OMAP: DMA: Replace read/write macros with functions
>        OMAP: DMA: Introduce errata handling feature
>        OMAP2420: hwmod data: add system DMA
>        OMAP2430: hwmod data: add system DMA
>        OMAP3: hwmod data: add system DMA
>        OMAP1: DMA: Implement in platform device model
>        OMAP2+: DMA: hwmod: Device registration
>        OMAP: DMA: Convert DMA library into platform driver
>
>   arch/arm/mach-omap1/Makefile               |    2 +-
>   arch/arm/mach-omap1/dma.c                  |  390 ++++++++++++++++
>   arch/arm/mach-omap2/Makefile               |    2 +-
>   arch/arm/mach-omap2/dma.c                  |  297 ++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   86 ++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   86 ++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   97 ++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  101 ++++
>   arch/arm/plat-omap/dma.c                   |  697
> ++++++++++++----------------
>   arch/arm/plat-omap/include/plat/dma.h      |  232 ++++------
>   10 files changed, 1450 insertions(+), 540 deletions(-)
>   create mode 100644 arch/arm/mach-omap1/dma.c
>   create mode 100644 arch/arm/mach-omap2/dma.c

