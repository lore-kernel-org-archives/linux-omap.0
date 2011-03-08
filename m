From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2 01/18] I2C: OMAP2+: Set hwmod flags to only allow 16-bit
 accesses to i2c
Date: Tue, 8 Mar 2011 16:14:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081613580.15132@utopia.booyaka.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com> <20110308110727.23531.15577.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47199 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab1CHXOa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:14:30 -0500
In-Reply-To: <20110308110727.23531.15577.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

On Tue, 8 Mar 2011, Andy Green wrote:

> Peter Maydell noticed when running under QEMU he was getting
> errors reporting 32-bit access to I2C peripheral unit registers
> that are documented to be 8 or 16-bit only[1][2]
> 
> The I2C driver is blameless as it wraps its accesses in a
> function using __raw_writew and __raw_readw, it turned out it
> is the hwmod stuff.
> 
> However the hwmod code already has a flag to force a
> perhipheral unit to only be accessed using 16-bit operations.
> 
> This patch applies the 16-bit only flag to the 2430,
> OMAP3xxx and OMAP44xx hwmod structs.  2420 was already
> correctly marked up as 16-bit.
> 
> The 2430 change will need testing by TI as arranged
> in the comments to the previous patch version.
> 
> When the 16-bit flag is or-ed with other flags, it is placed
> first as requested in comments.
> 
> [1] OMAP4430 Technical reference manual section 23.1.6.2
> [2] OMAP3530 Techincal reference manual section 18.6
> 
> Cc: patches@linaro.org
> Cc: Ben Dooks <ben-linux@fluff.org>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>

For the OMAP2/3 hwmod data changes, makes sense to me.  

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
