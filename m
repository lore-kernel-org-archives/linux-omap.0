From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: edma: Implement device_synchronize callback
Date: Thu, 11 Feb 2016 11:00:57 +0200
Message-ID: <56BC4DC9.6000309@ti.com>
References: <1455180872-2620-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455180872-2620-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/11/2016 10:54 AM, Peter Ujfalusi wrote:
> We need the callback to support the dmaengine_terminate_sync().

I have made some typos and I only compiled the kernel after sending the=
 patch..
Resending.

>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/edma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 2dac314a2d7a..ea0d919a3318 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -869,6 +869,13 @@ static int edma_terminate_all(struct dma_chan *c=
han)
>  	return 0;
>  }
> =20
> +static void edma_synchronize(struct dma_chan *c)
> +{
> +	struct edma_chan *echan =3D to_edma_chan(chan);
> +
> +	vchan_synchronize(&echan->vchan);
> +}
> +
>  static int edma_slave_config(struct dma_chan *chan,
>  	struct dma_slave_config *cfg)
>  {
> @@ -1808,6 +1815,7 @@ static void edma_dma_init(struct edma_cc *ecc, =
bool legacy_mode)
>  	s_ddev->device_pause =3D edma_dma_pause;
>  	s_ddev->device_resume =3D edma_dma_resume;
>  	s_ddev->device_terminate_all =3D edma_terminate_all;
> +	s_ddev->device_synchronize =3D edma_synchronize;
> =20
>  	s_ddev->src_addr_widths =3D EDMA_DMA_BUSWIDTHS;
>  	s_ddev->dst_addr_widths =3D EDMA_DMA_BUSWIDTHS;
> @@ -1833,6 +1841,7 @@ static void edma_dma_init(struct edma_cc *ecc, =
bool legacy_mode)
>  		m_ddev->device_pause =3D edma_dma_pause;
>  		m_ddev->device_resume =3D edma_dma_resume;
>  		m_ddev->device_terminate_all =3D edma_terminate_all;
> +		m_ddev->device_synchronize =3D edma_synchronize;
> =20
>  		m_ddev->src_addr_widths =3D EDMA_DMA_BUSWIDTHS;
>  		m_ddev->dst_addr_widths =3D EDMA_DMA_BUSWIDTHS;
>=20


--=20
P=E9ter
