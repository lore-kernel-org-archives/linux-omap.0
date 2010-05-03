From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv4 0/2] omap-sham: OMAP SHA1/MD5 driver
Date: Mon, 3 May 2010 11:11:39 +0800
Message-ID: <20100503031139.GA31376@gondor.apana.org.au>
References: <cover.1272464135.git.dmitry.kasatkin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:47028 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754361Ab0ECDLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 23:11:42 -0400
Content-Disposition: inline
In-Reply-To: <cover.1272464135.git.dmitry.kasatkin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Apr 28, 2010 at 05:18:05PM +0300, Dmitry Kasatkin wrote:
> Changes to v4:
> - concurrent requests support via queue
> - hmac
> - shash support removed
> 
> Dmitry Kasatkin (2):
>   crypto: updates omap sham device related platform code
>   crypto: omap-sham - omap sha1 & md5 driver

Both patches applied.  Thanks for all your hard work Dmitry!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
