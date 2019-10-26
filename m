From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 07/10] crypto: omap-aes-gcm: fix corner case with only
 auth data
Date: Sat, 26 Oct 2019 17:04:05 +0200
Message-ID: <CAKv+Gu-4j3yUT7ekPukj1t50WXuNBb+XwwCqP7qHCkH_ZE9ipw@mail.gmail.com>
References: <20191017122549.4634-1-t-kristo@ti.com>
 <20191017122549.4634-8-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191017122549.4634-8-t-kristo@ti.com>
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
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-omap@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Oct 2019 at 14:26, Tero Kristo <t-kristo@ti.com> wrote:
>
> Fix a corner case where only authdata is generated, without any provided
> assocdata / cryptdata. Passing the empty scatterlists to OMAP AES core driver
> in this case would confuse it, failing to map DMAs.
>

So this change appears to be the culprit for causing the remaining
issue that I reported in the cover letter of the followup series that
I sent out.

The logic below does not account for the case where only assocdata is
provided, which is a valid use of an AEAD.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/crypto/omap-aes-gcm.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/crypto/omap-aes-gcm.c b/drivers/crypto/omap-aes-gcm.c
> index 9bbedbccfadf..dfd4d1cac421 100644
> --- a/drivers/crypto/omap-aes-gcm.c
> +++ b/drivers/crypto/omap-aes-gcm.c
> @@ -148,12 +148,14 @@ static int omap_aes_gcm_copy_buffers(struct omap_aes_dev *dd,
>         if (req->src == req->dst || dd->out_sg == sg_arr)
>                 flags |= OMAP_CRYPTO_FORCE_COPY;
>
> -       ret = omap_crypto_align_sg(&dd->out_sg, cryptlen,
> -                                  AES_BLOCK_SIZE, &dd->out_sgl,
> -                                  flags,
> -                                  FLAGS_OUT_DATA_ST_SHIFT, &dd->flags);
> -       if (ret)
> -               return ret;
> +       if (cryptlen) {
> +               ret = omap_crypto_align_sg(&dd->out_sg, cryptlen,
> +                                          AES_BLOCK_SIZE, &dd->out_sgl,
> +                                          flags,
> +                                          FLAGS_OUT_DATA_ST_SHIFT, &dd->flags);
> +               if (ret)
> +                       return ret;
> +       }
>
>         dd->in_sg_len = sg_nents_for_len(dd->in_sg, alen + clen);
>         dd->out_sg_len = sg_nents_for_len(dd->out_sg, clen);
> @@ -287,8 +289,12 @@ static int omap_aes_gcm_handle_queue(struct omap_aes_dev *dd,
>                 return err;
>
>         err = omap_aes_write_ctrl(dd);
> -       if (!err)
> -               err = omap_aes_crypt_dma_start(dd);
> +       if (!err) {
> +               if (dd->in_sg_len && dd->out_sg_len)
> +                       err = omap_aes_crypt_dma_start(dd);
> +               else
> +                       omap_aes_gcm_dma_out_callback(dd);
> +       }
>
>         if (err) {
>                 omap_aes_gcm_finish_req(dd, err);
> --
> 2.17.1
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
