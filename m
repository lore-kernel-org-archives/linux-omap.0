From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: linux-next: manual merge of the crypto tree with the omap tree
Date: Mon, 27 Sep 2010 12:41:00 +0800
Message-ID: <20100927044100.GA30155@gondor.apana.org.au>
References: <20100927143300.9fa73063.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100927143300.9fa73063.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 27, 2010 at 02:33:00PM +1000, Stephen Rothwell wrote:
> Hi Herbert,
> 
> Today's linux-next merge of the crypto tree got a conflict in
> arch/arm/mach-omap2/devices.c between commit
> 5d14f2792f9d63c5d25903bd048017c4b53c7d9a ("omap: crypto: updates to
> enable omap aes") from the omap tree and commit
> b744c679f62b368cb94c21c1dcd4618e42d88d63 ("crypto: updates to enable omap
> aes") from the crypto tree.
> 
> Two versions of the same patch.  The version in the omap tree has been
> updated, so I used that.

Thanks for the note Stephen.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
