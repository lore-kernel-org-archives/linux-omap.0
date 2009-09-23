From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH] SDMA: Fixing bug in omap_dma_set_global_params()
Date: Wed, 23 Sep 2009 13:54:30 +0530
Message-ID: <618f0c910909230124q773b90f6xd377e67a758e1237@mail.gmail.com>
References: <1253690346-17865-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754571AbZIWIYd@vger.kernel.org>
In-Reply-To: <1253690346-17865-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 23, 2009 at 12:49 PM, Anuj Aggarwal <anuj.aggarwal@ti.com> =
wrote:
> Argument tparams was not being used to program
> global register GCR.HI_THREAD_RESERVED. This patch fixes the same.
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
> =A0arch/arm/plat-omap/dma.c | =A0 13 +++++++------
> =A01 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index bf08634..7a7b6df 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -829,10 +829,10 @@ EXPORT_SYMBOL(omap_free_dma);
> =A0*
> =A0* @param arb_rate
> =A0* @param max_fifo_depth
> - * @param tparams - Number of thereads to reserve : DMA_THREAD_RESER=
VE_NORM
> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_THREAD_RESERVE_ONET
> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_THREAD_RESERVE_TWOT
> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_THREAD_RESERVE_THREET
> + * @param tparams - Number of threads to reserve : DMA_THREAD_RESERV=
E_NORM
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_THREAD_RESERVE_ONET
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_THREAD_RESERVE_TWOT
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_THREAD_RESERVE_THREET
> =A0*/
> =A0void
> =A0omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int t=
params)
> @@ -847,8 +847,9 @@ omap_dma_set_global_params(int arb_rate, int max_=
fifo_depth, int tparams)
> =A0 =A0 =A0 =A0if (arb_rate =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arb_rate =3D 1;
>
> - =A0 =A0 =A0 reg =3D (arb_rate & 0xff) << 16;
> - =A0 =A0 =A0 reg |=3D (0xff & max_fifo_depth);
> + =A0 =A0 =A0 reg =3D 0xff & max_fifo_depth;
> + =A0 =A0 =A0 reg |=3D (0x3 & tparams) << 12;
> + =A0 =A0 =A0 reg |=3D (arb_rate & 0xff) << 16;
>
> =A0 =A0 =A0 =A0dma_write(reg, GCR);
> =A0}

max_fifo_depth should not be set to zero. Perhaps it deserves a check
similar to arb_rate ?
