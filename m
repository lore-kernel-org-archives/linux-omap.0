From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 6/7] crypto: omap-aes: Add support for GCM mode
Date: Sat, 11 Jul 2015 10:40:43 +0800
Message-ID: <20150711024043.GC24197@gondor.apana.org.au>
References: <1436283109-13318-1-git-send-email-lokeshvutla@ti.com>
 <1436283109-13318-7-git-send-email-lokeshvutla@ti.com>
 <20150708041838.GA12744@gondor.apana.org.au>
 <559FD21F.2020903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559FD21F.2020903@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 10, 2015 at 07:39:35PM +0530, Lokesh Vutla wrote:
>
> If you don't mind can you elaborate more on the usage of rctx and ctx
> in the driver?

The ctx is a property of the tfm and it's shared by all users
of that tfm.  So it must not be written to unless you use locking.

The reqeust context on the other hand is specific to a request
so it can be used to store information.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
