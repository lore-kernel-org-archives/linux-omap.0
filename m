From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3] crypto: omap-aes: Add support for GCM mode
Date: Fri, 18 Sep 2015 21:17:13 +0800
Message-ID: <20150918131713.GF7638@gondor.apana.org.au>
References: <1436283109-13318-7-git-send-email-lokeshvutla@ti.com>
 <1442323681-6538-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442323681-6538-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 15, 2015 at 06:58:01PM +0530, Lokesh Vutla wrote:
>
> +	assoc = &req->src[0];
> +	sg_init_table(dd->in_sgl, nsg + 1);
> +	if (assoclen) {
> +		if (omap_aes_check_aligned(assoc, assoclen)) {
> +			dd->sgs_copied |= AES_ASSOC_DATA_COPIED;
> +			pages = get_order(alen);
> +			buf_in = (void *)__get_free_pages(GFP_ATOMIC, pages);

It would be better if you used a list of pages rather than n
contiguous pages which is likely to fail.

> +			buf_in = sg_virt(assoc);

This is bogus as assoc may not be mapped.

> +	if (req->cryptlen) {
> +		input = scatterwalk_ffwd(tmp, req->src, req->assoclen);

scatterwalk_ffwd may return tmp so tmp must not be on the stack
unless you stop using input after the function returns.  Also tmp
must not be reused by a subsequent call to scatterwalk_ffwd.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
