From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 09/10] crypto: add timeout to crypto_wait_req
Date: Sat, 9 Nov 2019 13:01:08 +0800
Message-ID: <20191109050108.mcykgg2izb7htrek@gondor.apana.org.au>
References: <20191017122549.4634-1-t-kristo@ti.com>
 <20191017122549.4634-10-t-kristo@ti.com>
 <CAOtvUMeBXjDBhSVgMOW=hshEx_AkNPg-Zk2c2jCDzY8vyXWW5g@mail.gmail.com>
 <076f0bc6-ad04-9543-db02-d7c7060db036@ti.com>
 <CAOtvUMc7pbtPAPUbEmz_MTHmB9LboQVdgG-t9tHCr=biEbFuUQ@mail.gmail.com>
 <20191108022759.GB1140@sol.localdomain>
 <d55c0182-5fb0-2ef9-f056-54b396fb0026@ti.com>
 <20191108091608.i5fxt2vu2nwrybgn@gondor.apana.org.au>
 <2ab94492-21e4-fbe0-41eb-e12b02511d7c@ti.com>
 <20191109022749.GB9739@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191109022749.GB9739@sol.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Gilad Ben-Yossef <gilad@benyossef.com>, David Miller <davem@davemloft.net>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-omap@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 08, 2019 at 06:27:49PM -0800, Eric Biggers wrote:
> 
> I don't see how making crypto_wait_req killable would be any better than adding
> a timeout, since in both cases the crypto operation would still be proceeding in
> the background while things are being freed.

Right, you would need to modify the caller to actually distinguish
between the killed case vs. actual completion.

> Would it help if the crypto self-tests printed a pr_debug() message when
> starting each test vector?  These wouldn't be shown by default, but it would be
> possible to enable them using dynamic-debug or by adding '#define DEBUG' to the
> top of the source file.

This should be simpler to implement.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
