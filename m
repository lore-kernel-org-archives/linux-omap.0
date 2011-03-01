From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/4] OMAP2/3: clockdomains: remove warnings on an OMAP3-only
 compile
Date: Mon, 28 Feb 2011 17:17:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102281716460.29478@utopia.booyaka.com>
References: <20110226001601.28142.46636.stgit@twilight.localdomain> <20110226002006.28142.52520.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143Ab1CAARj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 19:17:39 -0500
In-Reply-To: <20110226002006.28142.52520.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 25 Feb 2011, Paul Walmsley wrote:

> Resolve these compile-time gcc warnings on OMAP3-only kernel compiles:
> 
> .../mach-omap2/clockdomains2xxx_3xxx_data.c:95: warning: 'dsp_24xx_wkdeps' defined but not used
> .../mach-omap2/clockdomains2xxx_3xxx_data.c:119: warning: 'mpu_24xx_wkdeps' defined but not used
> .../mach-omap2/clockdomains2xxx_3xxx_data.c:147: warning: 'core_24xx_wkdeps' defined but not used
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

For the archives, I've dropped this patch and replaced it with Sanjeev's 
patch here:

    http://marc.info/?l=linux-omap&m=129893821929982&w=2


- Paul
