From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 5/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
Date: Fri, 22 Jun 2012 12:39:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206221237290.10198@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-6-git-send-email-t-kristo@ti.com> <4FE45ACF.3070200@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39842 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab2FVSjF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 14:39:05 -0400
In-Reply-To: <4FE45ACF.3070200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> While testing with one of Tero's OMAP4 OFF mode support branches (which
> also include these patches) I found a OMAP4 standalone build fails
> here..
> 
> CC      arch/arm/mach-omap2/omap_hwmod.o
> arch/arm/mach-omap2/omap_hwmod.c: In function '_reconfigure_io_chain':
> arch/arm/mach-omap2/omap_hwmod.c:1797: error: implicit declaration of function
> 'omap3xxx_prm_reconfigure_io_chain'
> make[1]: *** [arch/arm/mach-omap2/omap_hwmod.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

This should be fixed by Kevin's "ARM: OMAP2+: PRM: fix compile for 
OMAP4-only build" patch, part of the following pull request:

http://marc.info/?l=linux-omap&m=134037965609802&w=2


- Paul
