From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/8] ARM: OMAP2+: hwmod: Remove remaining DMA channel
 definitions
Date: Mon, 17 Jun 2013 03:29:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306170328080.4477@utopia.booyaka.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com> <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48140 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab3FQD3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Jun 2013 23:29:16 -0400
In-Reply-To: <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Sat, 15 Jun 2013, Jarkko Nikula wrote:

> Last remaining DMA channel definitions in arch/arm/mach-omap2/dma.h
> are used only by omap_hwmod_2xxx_3xxx_ipblock_data.c and
> omap_hwmod_3xxx_data.c. Remove them by using directly DMA channel number in
> hwmod data and drop definitions with a following script:
> 
> egrep '#define [OMAP|AM35XX].*DMA' arch/arm/mach-omap2/dma.h | cut -f 1,3 \
> 	| while read i; do \
> 		DEF=`echo $i |cut -d ' ' -f 2`; \
> 		CH=`echo $i |cut -d ' ' -f 3`; \
> 		echo "removing" $DEF; \
> 		sed -i "s/${DEF}/${CH}/" arch/arm/mach-omap2/omap_hwmod_*.c; \
> 		sed -i "/${DEF}/d" arch/arm/mach-omap2/dma.h; \
> 	done
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Looks fine to me for v3.12.  I guess Tony will take this series.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
