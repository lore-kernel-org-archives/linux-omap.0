From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 01/10] crypto: omap-aes: Add support for lengths not
 aligned with AES_BLOCK_SIZE
Date: Mon, 6 Jul 2015 15:38:33 +0800
Message-ID: <20150706073833.GB20192@gondor.apana.org.au>
References: <1435814320-30347-1-git-send-email-lokeshvutla@ti.com>
 <1435814320-30347-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435814320-30347-2-git-send-email-lokeshvutla@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 02, 2015 at 10:48:31AM +0530, Lokesh Vutla wrote:
> OMAP AES driver returns an error if the data is not aligned with
> AES_BLOCK_SIZE bytes.
> But OMAP AES hw allows data input upto 1 byte aligned, but still
> zeros are to be appended and complete AES_BLOCK_SIZE has to be written.
> And correct length has to be passed in LENGTH field.
> Adding support for inputs not aligned with AES_BLOCK_SIZE.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Please explain the purpose of this patch.  As it stands your change
log makes no sense.  If you're relaxing the check for GCM support
then you should state that explicitly.  Because partial blocks make
no sense otherwise.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
