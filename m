From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/7] crypto: omap-sham updates
Date: Sat, 20 Oct 2012 19:34:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201930440.27264@utopia.booyaka.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53816 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab2JTTew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 15:34:52 -0400
In-Reply-To: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 19 Oct 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> This series updates the crypto omap-sham driver and supporting
> infrastructure.

Looks pretty good; this will make it easier for us to migrate the 
omap_hwmod code to a LDM bus.  Will reply to the original patches with a 
few comments and questions.

One general comment - for us to merge these through the OMAP tree, we'll 
need acks from the hardware crypto folks.  AFAIK they are:

CRYPTO API
M:      Herbert Xu <herbert@gondor.apana.org.au>
M:      "David S. Miller" <davem@davemloft.net>
L:      linux-crypto@vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
S:      Maintained
F:      Documentation/crypto/
F:      arch/*/crypto/
F:      crypto/
F:      drivers/crypto/
F:      include/crypto/

So it would be helpful if you could send those patches along to those 
people and lists too, and ask them for acks.


- Paul
