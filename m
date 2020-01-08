From: Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH v4 03/11] mmc: sdhci: add support for using external DMA devices
Date: Wed, 8 Jan 2020 17:29:51 +0800
Message-ID: <CADBw62rK1a9K7cxf5ti7YkFsJJ5tJ+8yjuF2aYR3PnZnoK-r2g@mail.gmail.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com> <20200106110133.13791-4-faiz_abbas@ti.com>
 <CADBw62onwxPmn=HmdL05hz+FOUe9crRPDO+CB5hDmaVeYMSTsQ@mail.gmail.com> <48c10fdf-f2c7-a719-2f64-0f87895f3704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48c10fdf-f2c7-a719-2f64-0f87895f3704@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, kishon@ti.com, Adrian Hunter <adrian.hunter@intel.com>, mark.rutland@arm.com, robh+dt@kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Faiz,

On Wed, Jan 8, 2020 at 5:19 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Baolin,
>
> On 08/01/20 6:58 am, Baolin Wang wrote:
> > Hi Faiz,
> >
> > On Mon, Jan 6, 2020 at 7:01 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>
> >> From: Chunyan Zhang <zhang.chunyan@linaro.org>
> >>
> >> Some standard SD host controllers can support both external dma
> >> controllers as well as ADMA/SDMA in which the SD host controller
> >> acts as DMA master. TI's omap controller is the case as an example.
> >>
> >> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> >> the host controller but does not have any support for external DMA
> >> controllers implemented using dmaengine, meaning that custom code is
> >> needed for any systems that use an external DMA controller with SDHCI.
> >>
> >> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
> >> 1. Map scatterlists before dmaengine_prep_slave_sg()
> >> 2. Use dma_async() functions inside of the send_command() path and call
> >> terminate_sync() in non-atomic context in case of an error.
> >>
> >> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> >> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >> ---
> >>  drivers/mmc/host/Kconfig |   3 +
> >>  drivers/mmc/host/sdhci.c | 228 ++++++++++++++++++++++++++++++++++++++-
> >>  drivers/mmc/host/sdhci.h |   8 ++
> >>  3 files changed, 237 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index d06b2dfe3c95..adef971582a1 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -1040,3 +1040,6 @@ config MMC_OWL
> >>         help
> >>           This selects support for the SD/MMC Host Controller on
> >>           Actions Semi Owl SoCs.
> >> +
> >> +config MMC_SDHCI_EXTERNAL_DMA
> >> +       bool
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index f6999054abcf..8cc78c76bc3d 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -10,6 +10,7 @@
> >>   */
> >>
> >>  #include <linux/delay.h>
> >> +#include <linux/dmaengine.h>
> >>  #include <linux/ktime.h>
> >>  #include <linux/highmem.h>
> >>  #include <linux/io.h>
> >> @@ -1157,6 +1158,188 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> >>         sdhci_set_block_info(host, data);
> >>  }
> >>
> >> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> >> +
> >> +static int sdhci_external_dma_init(struct sdhci_host *host)
> >> +{
> >> +       int ret = 0;
> >> +       struct mmc_host *mmc = host->mmc;
> >> +
> >> +       host->tx_chan = dma_request_chan(mmc->parent, "tx");
> >> +       if (IS_ERR(host->tx_chan)) {
> >> +               ret = PTR_ERR(host->tx_chan);
> >> +               if (ret != -EPROBE_DEFER)
> >> +                       pr_warn("Failed to request TX DMA channel.\n");
> >> +               host->tx_chan = NULL;
> >> +               return ret;
> >> +       }
> >> +
> >> +       host->rx_chan = dma_request_chan(mmc->parent, "rx");
> >> +       if (IS_ERR(host->rx_chan)) {
> >> +               if (host->tx_chan) {
> >> +                       dma_release_channel(host->tx_chan);
> >> +                       host->tx_chan = NULL;
> >> +               }
> >> +
> >> +               ret = PTR_ERR(host->rx_chan);
> >> +               if (ret != -EPROBE_DEFER)
> >> +                       pr_warn("Failed to request RX DMA channel.\n");
> >> +               host->rx_chan = NULL;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
> >> +                                                  struct mmc_data *data)
> >> +{
> >> +       return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
> >> +}
> >> +
> >> +static int sdhci_external_dma_setup(struct sdhci_host *host,
> >> +                                   struct mmc_command *cmd)
> >> +{
> >> +       int ret, i;
> >> +       struct dma_async_tx_descriptor *desc;
> >> +       struct mmc_data *data = cmd->data;
> >> +       struct dma_chan *chan;
> >> +       struct dma_slave_config cfg;
> >> +       dma_cookie_t cookie;
> >> +       int sg_cnt;
> >> +
> >> +       if (!host->mapbase)
> >> +               return -EINVAL;
> >> +
> >> +       cfg.src_addr = host->mapbase + SDHCI_BUFFER;
> >> +       cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
> >> +       cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >> +       cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >> +       cfg.src_maxburst = data->blksz / 4;
> >> +       cfg.dst_maxburst = data->blksz / 4;
> >> +
> >> +       /* Sanity check: all the SG entries must be aligned by block size. */
> >> +       for (i = 0; i < data->sg_len; i++) {
> >> +               if ((data->sg + i)->length % data->blksz)
> >> +                       return -EINVAL;
> >> +       }
> >> +
> >> +       chan = sdhci_external_dma_channel(host, data);
> >> +
> >> +       ret = dmaengine_slave_config(chan, &cfg);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
> >> +       if (sg_cnt <= 0)
> >> +               return -EINVAL;
> >> +
> >> +       desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
> >> +                                      mmc_get_dma_dir(data),
> >> +                                      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >> +       if (!desc)
> >> +               return -EINVAL;
> >> +
> >> +       desc->callback = NULL;
> >> +       desc->callback_param = NULL;
> >> +
> >> +       cookie = dmaengine_submit(desc);
> >> +       if (cookie < 0)
> >
> > We usually use the DMA engine standard API: dma_submit_error() to
> > validate the cookie.
> >
>
> The if condition is doing the same thing as the API. Do we really
> require it?

Yes, now it did the same thing. But in future if the DMA engine expand
the cookie indication, which may break your current condition, but use
dma_submit_error() is more safe, that will help to cover the internal
cookie things. So I recommend to use the standard API as far as
possible.

But if Ulf does not care about this, it's Okay for me too :)
