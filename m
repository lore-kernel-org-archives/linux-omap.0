From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 09/10] crypto: add timeout to crypto_wait_req
Date: Fri, 8 Nov 2019 17:16:08 +0800
Message-ID: <20191108091608.i5fxt2vu2nwrybgn@gondor.apana.org.au>
References: <20191017122549.4634-1-t-kristo@ti.com>
 <20191017122549.4634-10-t-kristo@ti.com>
 <CAOtvUMeBXjDBhSVgMOW=hshEx_AkNPg-Zk2c2jCDzY8vyXWW5g@mail.gmail.com>
 <076f0bc6-ad04-9543-db02-d7c7060db036@ti.com>
 <CAOtvUMc7pbtPAPUbEmz_MTHmB9LboQVdgG-t9tHCr=biEbFuUQ@mail.gmail.com>
 <20191108022759.GB1140@sol.localdomain>
 <d55c0182-5fb0-2ef9-f056-54b396fb0026@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d55c0182-5fb0-2ef9-f056-54b396fb0026@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, linux-omap@vger.kernel.org, David Miller <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 08, 2019 at 09:40:57AM +0200, Tero Kristo wrote:
>
> The problem is not detecting a hung task, the problem is determining what
> caused the hang. Personally I don't care if the system dies if a crypto
> accelerator self test has failed, as long as I get reported about the exact
> nature of the failure. The failures are expected to happen only in
> development phase of a crypto driver.
> 
> With the timeout patch in place, I get reported what exact crypto test case
> failed and I can focus my debug efforts on that one.

If that's all you need then how about just making the wait killable?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
