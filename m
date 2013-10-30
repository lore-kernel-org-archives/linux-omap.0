From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] crypto: omap-aes: Fix CTR mode counter length
Date: Wed, 30 Oct 2013 12:11:44 +0800
Message-ID: <20131030041143.GE2957@gondor.apana.org.au>
References: <1383086258-22186-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383086258-22186-1-git-send-email-joelf@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 29, 2013 at 05:37:38PM -0500, Joel Fernandes wrote:
> NIST vectors for CTR mode in testmgr.h assume the entire IV as the counter. To
> get correct results that match the output of these vectors, we need to set the
> counter length correctly.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
