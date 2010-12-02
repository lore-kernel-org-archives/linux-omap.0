From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv2 0/6] omap-aes off mode and error handling fixes
Date: Thu, 2 Dec 2010 16:37:53 +0800
Message-ID: <20101202083753.GA23658@gondor.apana.org.au>
References: <cover.1291104329.git.dmitry.kasatkin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1291104329.git.dmitry.kasatkin@nokia.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 10:13:26AM +0200, Dmitry Kasatkin wrote:
> Changes to v1:
> - omap type specific handling removed
> - fixed backlog handling bug in "redundunt locking is removed"
> - aes module initialized once per request instead of dma transaction
>   more efficient and right way to do it
> - checkpatch fixes in separate patch

All applied.  Thanks Dmitry!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
