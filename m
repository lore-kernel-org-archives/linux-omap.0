From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Enable packed accesses for cyclic
 transfers
Date: Fri, 25 Sep 2015 10:00:42 +0300
Message-ID: <5604F11A.5040505@ti.com>
References: <1442233865-10412-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442233865-10412-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

Vinod,

On 09/14/2015 03:31 PM, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> The L3 throughput can be higher than expected when packed access
> is not enabled.  The ratio depends on the number of bytes in a
> transaction and the EMIF interface width.

Can you take a look at this patch?

Thanks,
P=E9ter

> The throughput was measured for the following settings/cases:
>=20
> * Case 1: Burst size of 64 bytes, packed access disabled
> * Case 2: Burst size of 64 bytes, packed access enabled
> * Case 3: Burst disabled, packed access disabled
>=20
> Throughput measurements were done during McASP-based audio
> playback on the Jacinto6 EVM using the omapconf tool [1]:
> $ omapconf trace bw -m sdma_rd
>=20
>  ---------------------------------------------------------
>                                   Throughput (MB/s)
>   Audio parameters            Case 1    Case 2    Case 3
>  ---------------------------------------------------------
>   44.1kHz, 16-bits, stereo      1.41      0.18      1.41
>   44.1kHz, 32-bits, stereo      1.41      0.35      1.41
>   44.1kHz, 16-bits, 4-chan      2.82      0.35      2.82
>   44.1kHz, 16-bits, 6-chan      4.23      0.53      4.23
>   44.1kHz, 16-bits, 8-chan      5.64      0.71      5.64
>  ---------------------------------------------------------
>=20
> From above measurements, case 2 is the only one that delivers
> the expected throughput for the given audio parameters.  For
> that reason, the packed accesses are now enabled.
>=20
> It's worth to mention that packed accesses cannot be enabled
> for all addressing modes. In cyclic transfers, it can be
> enabled in the source for MEM_TO_DEV and in dest for DEV_TO_MEM,
> as they use post-increment mode which supports packed accesses.
>=20
> Peter Ujfalusi:
> From the TRM regarding to this:
> "NOTE: Except in the constant addressing mode, the source or
> destination must be specified as packed for burst transactions
> to occur."
>=20
> So w/o the packed setting the burst on the MEM side was not
> enabled, this explains the numbers.
>=20
> [1] https://github.com/omapconf/omapconf
>=20
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/omap-dma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 249445c8a4c6..1dfc71c90123 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -935,8 +935,12 @@ static struct dma_async_tx_descriptor *omap_dma_=
prep_dma_cyclic(
>  		else
>  			d->ccr |=3D CCR_SYNC_ELEMENT;
> =20
> -		if (dir =3D=3D DMA_DEV_TO_MEM)
> +		if (dir =3D=3D DMA_DEV_TO_MEM) {
>  			d->ccr |=3D CCR_TRIGGER_SRC;
> +			d->csdp |=3D CSDP_DST_PACKED;
> +		} else {
> +			d->csdp |=3D CSDP_SRC_PACKED;
> +		}
> =20
>  		d->cicr |=3D CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
> =20
>=20
