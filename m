From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 00/13] crypto: omap fixes / changes for 4.13
Date: Sat, 10 Jun 2017 12:15:31 +0800
Message-ID: <20170610041531.GC14719@gondor.apana.org.au>
References: <1495611334-15039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1495611334-15039-1-git-send-email-t-kristo@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: lokeshvutla@ti.com, davem@davemloft.net, linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 24, 2017 at 10:35:21AM +0300, Tero Kristo wrote:
> Hi,
> 
> This series has a number of fixes towards 4.13 merge window (I don't
> think we need to rush these as nobody has complained of any of the
> issues so far), and the addition of AES GCM mode. Lokesh posted
> the support patch for GCM quite a while back, I have addressed
> the comments received back then as well as I could and done some
> additional changes on top. The series also introduces a base
> OMAP crypto support library for handling the various cases
> of buffer alignment. This is now used for both AES/DES. Addition
> of SHA to this is still pending as it requires certain things
> to be done slightly differently (need a couple of new flags for
> the API I believe.)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
