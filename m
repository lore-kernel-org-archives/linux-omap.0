From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP: TI816X: add clock domain support for TI816x
Date: Mon, 16 Sep 2013 08:14:54 -0500
Message-ID: <20130916131451.GB14873@kahuna>
References: <1377352941-29699-1-git-send-email-aida.mynzhasova@skitlab.ru>
 <5236A9FA.2040100@skitlab.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40289 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab3IPNO7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 09:14:59 -0400
Content-Disposition: inline
In-Reply-To: <5236A9FA.2040100@skitlab.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Cc: linux-omap@vger.kernel.org

On 10:49-20130916, Aida Mynzhasova wrote:
> On 24.08.2013 18:02, Aida Mynzhasova wrote:
> >This patch adds required definitions and structures for clockdomain
> >initialization, so omap3xxx_clockdomains_init() was substituted by
> >new ti81xx_clockdomains_init() while early initialization of
> >TI81XX platform.
> >
> >signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> >---
> >  arch/arm/mach-omap2/Makefile                   |   2 +
> >  arch/arm/mach-omap2/clockdomain.h              |   1 +
> >  arch/arm/mach-omap2/clockdomains_ti81xx_data.c | 208 +++++++++++++++++++++++++
> >  arch/arm/mach-omap2/cm-regbits-ti81xx.h        |  22 +++
> >  arch/arm/mach-omap2/cm_ti81xx.h                |  61 ++++++++
> >  arch/arm/mach-omap2/io.c                       |   2 +-
> >  6 files changed, 295 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/mach-omap2/clockdomains_ti81xx_data.c
> >  create mode 100644 arch/arm/mach-omap2/cm-regbits-ti81xx.h
> >  create mode 100644 arch/arm/mach-omap2/cm_ti81xx.h
> >
> 
[...]
> Can anybody please review my changes?

We are transitioning out of having clock information in mach-omap2 to
using devicetree

http://marc.info/?l=devicetree&m=137778225431749&w=2

Will be good to align the conversion with upcoming V7 of the patch
series as well.

-- 
Regards,
Nishanth Menon
