From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Build failure with DMA_OMAP=m and a caller built-in
Date: Tue, 8 Jan 2013 22:56:30 +0000
Message-ID: <201301082256.30639.arnd@arndb.de>
References: <1357449969.4324.25.camel@deadeye.wl.decadent.org.uk> <20130107202106.GG14149@atomide.com> <20130107203834.GB2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58283 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab3AHW4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jan 2013 17:56:37 -0500
In-Reply-To: <20130107203834.GB2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, linux-omap@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, linux-kbuild@vger.kernel.org

On Monday 07 January 2013, Russell King - ARM Linux wrote:
> The problem we have is that the way peripheral devices are connected to
> their DMA engines can involve additional complexity, which if not handled
> correctly results in some platforms being crippled by the API.
> 
> I think Vinod was working on something, however I've not heard anything on
> that for a while now.
> 
> How we avoid this problem outside of OMAP is that the DMA filter function
> gets passed from platform code, and we only ever allow the DMA engine
> driver to be configured into the kernel (iow, non-modular).  This means
> that the DMA users never directly reference the DMA engine driver itself.
> However, as OMAP headed down the DT path, many drivers no longer make use
> of platform data, which makes that approach impractical.

Hmm, it seems the generic DT binding for dmaengine missed the merge window
again, Vinod's pull request came a bit too late for this[1].

Anyway, once the binding and code from Jon Hunter is there, and the omap-dma
converted over to use it, the problem should be gone, unless you see any
other issues with it. Drivers no longer need to reference a filter function
directly, since the dma channel can get described completely in the DT.

	Arnd

[1] http://lkml.org/lkml/2012/12/21/466
