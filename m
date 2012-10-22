From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/7] ARM: OMAP2xxx: hwmod: Add DMA information for SHAM
 module
Date: Mon, 22 Oct 2012 19:53:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210221950330.13464@utopia.booyaka.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com> <1350683640-15044-3-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1210201940260.27264@utopia.booyaka.com> <20121022193714.GB1708@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57084 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab2JVTxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 15:53:07 -0400
In-Reply-To: <20121022193714.GB1708@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 22 Oct 2012, Mark A. Greer wrote:

> On Sat, Oct 20, 2012 at 07:40:44PM +0000, Paul Walmsley wrote:
> > On Fri, 19 Oct 2012, Mark A. Greer wrote:
> > 
> > > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > > 
> > > Add the DMA information for the OMAP2 SHA module.
> > > 
> > > CC: Paul Walmsley <paul@pwsan.com>
> > > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> > 
> > This can probably be combined with the first patch.
> 
> I made it a separate patch because the original omap2xxx code didn't
> support DMA and I wanted to keep the first patch an apples-apples
> conversion and _add_ functionality in this, separate, patch.
> 
> I prefer 2 patches but if you still want me to combine them, let me know.

OK, I see.  That's fine, then.  Maybe add a sentence about that into the 
patch description of #2, that this effectively enables a code path in 
the driver that wasn't being used before, and therefore should be in a 
separate patch for ease of bisecting?


- Paul
