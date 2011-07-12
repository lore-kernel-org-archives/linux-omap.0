From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride configuration
Date: Tue, 12 Jul 2011 09:47:19 +0530
Message-ID: <CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310310203-12288-1-git-send-email-sundaram@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sundaram Raju <sundaram@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux@arm.linux.org.uk, linus.walleij@linaro.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 10, 2011 at 8:33 PM, Sundaram Raju <sundaram@ti.com> wrote:
> Added new dma_ctrl_cmd TI_DMA_STRIDE_CONFIG to pass the TI DMA
> controller specific configurations on how a buffer must be walked
> through and how data is picked for transfer based on a specified
> pattern over the channel.
>
> The configuration passed is specific to the TI DMA controller used.
>
> Signed-off-by: Sundaram Raju <sundaram@ti.com>
> ---
> =C2=A0include/linux/dmaengine.h | =C2=A0 =C2=A05 +++++
> =C2=A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index eee7add..51dadc4 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -123,6 +123,10 @@ enum dma_ctrl_flags {
> =C2=A0* command.
> =C2=A0* @FSLDMA_EXTERNAL_START: this command will put the Freescale D=
MA controller
> =C2=A0* into external start mode.
> + * @TI_DMA_STRIDE_CONFIG: this command is only implemented by TI DMA
> + * controllers that need to pass special configuration on how to wal=
k through
> + * the buffer to pick up data in a specified pattern to be transferr=
ed in
> + * the channel.
> =C2=A0*/
> =C2=A0enum dma_ctrl_cmd {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DMA_TERMINATE_ALL,
> @@ -130,6 +134,7 @@ enum dma_ctrl_cmd {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DMA_RESUME,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DMA_SLAVE_CONFIG,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FSLDMA_EXTERNAL_START,
> + =C2=A0 =C2=A0 =C2=A0 TI_DMA_STRIDE_CONFIG,
> =C2=A0};
IMHO this isn't very correct.

1) Striding, in one form or other, is supported by other DMACs as well.
   The number will only increase in future.
   Are we to add  <VENDOR>_DMA_STRIDE_CONFIG for each case ?

2) As Dan noted, client drivers are going to have ifdef hackery in
order to be common
 to other SoCs.

3) TI may not have just one DMAC IP used in all the SoCs. So if you wan=
t
  vendor specific defines anyway, please atleast also add DMAC version =
to it.
  Something like
>        DMA_SLAVE_CONFIG,
>        FSLDMA_EXTERNAL_START,
> +       TI_DMA_v1_STRIDE_CONFIG,
