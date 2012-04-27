From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/12] mmc: omap_hsmmc: add DMA engine support
Date: Fri, 27 Apr 2012 21:00:22 +0200
Message-ID: <CACRpkdZPEnPTpp+vwJed4ZkXLNjEVUz==YVvwg_bhuUOyD3Fxg@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 23, 2012 at 6:05 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP HSMMC driver. =A0This supplements =
the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Great,

> +#if 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig =3D host->dma_line_rx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rx_chan =3D dma_request_channel(m=
ask, omap_dma_filter_fn, &sig);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->rx_chan) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(mmc_dev(host->=
mmc), "unable to obtain RX DMA engine channel %u\n", sig);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#endif
> +#if 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig =3D host->dma_line_tx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tx_chan =3D dma_request_channel(m=
ask, omap_dma_filter_fn, &sig);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->tx_chan) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(mmc_dev(host->=
mmc), "unable to obtain TX DMA engine channel %u\n", sig);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#endif

Are these development artifacts?

Apart from that:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
