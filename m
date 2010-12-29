From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/1] omap-sham: backlog handling fix
Date: Wed, 29 Dec 2010 21:52:19 +1100
Message-ID: <20101229105218.GA9787@gondor.apana.org.au>
References: <cover.1293616613.git.dmitry.kasatkin@nokia.com> <16ffeda30b634b3ee0c9b55220b30dd689c5d182.1293616613.git.dmitry.kasatkin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16ffeda30b634b3ee0c9b55220b30dd689c5d182.1293616613.git.dmitry.kasatkin@nokia.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 29, 2010 at 11:58:28AM +0200, Dmitry Kasatkin wrote:
> Previous commit "removed redundant locking" introduced
> a bug in handling backlog.
> In certain cases, when async request complete callback will
> call complete() on -EINPROGRESS code, it will cause uncompleted requests.
> It does not happen in implementation similar to crypto test manager,
> but it will happen in implementation similar to dm-crypt.
> Backlog needs to be checked before dequeuing next request.
> 
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

Patch applied.  Thanks Dmitry.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
