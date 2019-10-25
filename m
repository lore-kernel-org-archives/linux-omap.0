From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 05/27] crypto: omap - switch to skcipher API
Date: Fri, 25 Oct 2019 12:19:29 +0200
Message-ID: <CAKv+Gu_0HejeZLEft1VQpPruW+L8Ao1J2fFhp-io_sVZnUVxbg@mail.gmail.com>
References: <20191024132345.5236-1-ard.biesheuvel@linaro.org>
 <20191024132345.5236-6-ard.biesheuvel@linaro.org>
 <20191024134123.GW5610@atomide.com>
 <CAKv+Gu_xTe8qmPab=_UE_buxaSzj2Kxtq+CPrm-cawAyg8MUzg@mail.gmail.com>
 <2b461903-dbbc-1f1c-2359-6dae656d477c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2b461903-dbbc-1f1c-2359-6dae656d477c@ti.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Biggers <ebiggers@google.com>, Tony Lindgren <tony@atomide.com>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 25 Oct 2019 at 09:32, Tero Kristo <t-kristo@ti.com> wrote:
>
> On 24/10/2019 16:42, Ard Biesheuvel wrote:
> > On Thu, 24 Oct 2019 at 15:41, Tony Lindgren <tony@atomide.com> wrote:
> >>
> >> * Ard Biesheuvel <ard.biesheuvel@linaro.org> [191024 13:24]:
> >>> Commit 7a7ffe65c8c5 ("crypto: skcipher - Add top-level skcipher interface")
> >>> dated 20 august 2015 introduced the new skcipher API which is supposed to
> >>> replace both blkcipher and ablkcipher. While all consumers of the API have
> >>> been converted long ago, some producers of the ablkcipher remain, forcing
> >>> us to keep the ablkcipher support routines alive, along with the matching
> >>> code to expose [a]blkciphers via the skcipher API.
> >>>
> >>> So switch this driver to the skcipher API, allowing us to finally drop the
> >>> blkcipher code in the near future.
> >>
> >> Adding Tero to Cc on this one.
> >>
> >
> > Ah, of course - apologies for missing that.
>
> Works for me, also can't find any bugs in the code via inspection, so
> feel free to add:
>
> Reviewed-by: Tero Kristo <t-kristo@ti.com>
> Tested-by: Tero Kristo <t-kristo@ti.com>
>


Thanks Tero

I'll dig up my Beaglebone White today and test/review the patches you
sent out last week.
