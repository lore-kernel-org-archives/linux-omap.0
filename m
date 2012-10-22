From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 2/7] ARM: OMAP2xxx: hwmod: Add DMA information for SHAM
 module
Date: Mon, 22 Oct 2012 12:37:14 -0700
Message-ID: <20121022193714.GB1708@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
 <1350683640-15044-3-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1210201940260.27264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:46137 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab2JVThQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 15:37:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210201940260.27264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Oct 20, 2012 at 07:40:44PM +0000, Paul Walmsley wrote:
> On Fri, 19 Oct 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > Add the DMA information for the OMAP2 SHA module.
> > 
> > CC: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> This can probably be combined with the first patch.

I made it a separate patch because the original omap2xxx code didn't
support DMA and I wanted to keep the first patch an apples-apples
conversion and _add_ functionality in this, separate, patch.

I prefer 2 patches but if you still want me to combine them, let me know.

Mark
--
