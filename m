From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 0/7] crypto: omap-sham updates
Date: Mon, 22 Oct 2012 12:38:29 -0700
Message-ID: <20121022193829.GC1708@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1210201930440.27264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:49186 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab2JVTia (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 15:38:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210201930440.27264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Oct 20, 2012 at 07:34:51PM +0000, Paul Walmsley wrote:
> On Fri, 19 Oct 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > This series updates the crypto omap-sham driver and supporting
> > infrastructure.
> 
> Looks pretty good; this will make it easier for us to migrate the 
> omap_hwmod code to a LDM bus.  Will reply to the original patches with a 
> few comments and questions.
> 
> One general comment - for us to merge these through the OMAP tree, we'll 
> need acks from the hardware crypto folks.  AFAIK they are:
> 
> CRYPTO API
> M:      Herbert Xu <herbert@gondor.apana.org.au>
> M:      "David S. Miller" <davem@davemloft.net>
> L:      linux-crypto@vger.kernel.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
> S:      Maintained
> F:      Documentation/crypto/
> F:      arch/*/crypto/
> F:      crypto/
> F:      drivers/crypto/
> F:      include/crypto/
> 
> So it would be helpful if you could send those patches along to those 
> people and lists too, and ask them for acks.

I will do that.  Thanks for your feedback.

Mark
--
