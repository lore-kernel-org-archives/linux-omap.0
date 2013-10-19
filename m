From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 09/11] ARM: OMAP3: PRM: move iva2 force idle functionality
 to PRM driver
Date: Sat, 19 Oct 2013 17:36:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191732240.12900@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-10-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49029 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab3JSRgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:36:04 -0400
In-Reply-To: <1381508141-15244-10-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> This is correct location for this instead of the PM core, as it is accessing
> PRM registers directly.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This is custom reset code for the IVA2, not specifically PRM code, so it 
should go into a separate arch/arm/mach-omap2/iva2.c file, before it gets 
moved out into drivers/.  (Similar to what's been done for 
mach-omap2/i2c.c and mach-omap2/hdq1w.c, etc.)  Unfortunately, this is 
going to require separate interfaces for all of those direct PRM register 
accesses as well.


- Paul
