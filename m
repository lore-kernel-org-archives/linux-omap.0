From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 00/11] crypto: omap-sham driver fixes
Date: Wed, 8 Jun 2011 21:08:34 +0800
Message-ID: <20110608130833.GD4582@gondor.apana.org.au>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Dmitry Kasatkin <dmitry.s.kasatkin@gmail.com>
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 02, 2011 at 09:10:02PM +0300, Dmitry Kasatkin wrote:
> Hi,
> 
> Recently we got crashes few times after some other patches to 2.6.32 kernel.
> This patch set greatly prevents race condition situations.
> No crashes are noticed any more.
> Now the driver should be ok for multi core as well.

All applied to cryptodev.  Thanks Dmitry!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
