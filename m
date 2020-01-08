From: Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH v4 02/11] mmc: sdhci: Factor out some operations set to
 their own functions
Date: Wed, 8 Jan 2020 09:32:43 +0800
Message-ID: <CADBw62pA3tub70Uvkz7_6HTqvpuvweroGJXScv5NdPcDViG0Dw@mail.gmail.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com> <20200106110133.13791-3-faiz_abbas@ti.com>
 <CADBw62qR5F8h4YbpWfU2UESeoR3zXzS=eePMvQHuT7NQE5hdSA@mail.gmail.com> <27fded85-d195-0a82-899a-bb6e727258dc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27fded85-d195-0a82-899a-bb6e727258dc@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, kishon@ti.com, Adrian Hunter <adrian.hunter@intel.com>, mark.rutland@arm.com, robh+dt@kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Faiz,

On Tue, Jan 7, 2020 at 3:20 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Baolin,
>
> On 07/01/20 12:04 pm, Baolin Wang wrote:
> > Hi Faiz,
> >
> > On Mon, Jan 6, 2020 at 7:01 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>
> >> In preparation for adding external dma support, factor out data initialization,
> >> block info and mrq_done to their own functions.
> >>
> >> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >> ---
> >>  drivers/mmc/host/sdhci.c | 96 +++++++++++++++++++++++-----------------
> >>  1 file changed, 55 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 1b1c26da3fe0..f6999054abcf 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -1025,18 +1025,9 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> >>         }
> >>  }
> >>
> >> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> >> +static void sdhci_initialize_data(struct sdhci_host *host,
> >> +                                 struct mmc_data *data)
> >>  {
> >> -       struct mmc_data *data = cmd->data;
> >> -
> >> -       host->data_timeout = 0;
> >> -
> >> -       if (sdhci_data_line_cmd(cmd))
> >> -               sdhci_set_timeout(host, cmd);
> >> -
> >> -       if (!data)
> >> -               return;
> >> -
> >>         WARN_ON(host->data);
> >>
> >>         /* Sanity checks */
> >> @@ -1048,6 +1039,36 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> >>         host->data_early = 0;
> >>         host->data->bytes_xfered = 0;
> >>
> >
> > Can you remove above redundant blank line?
> Ok.
> >
> >> +}
> >> +
> >> +static inline void sdhci_set_block_info(struct sdhci_host *host,
> >> +                                       struct mmc_data *data)
> >> +{
> >> +
> >
> > Ditto.
> Ok.
> >
> > Otherwise, please add my tested tag if feel free.
> >
> > Tested-by: Baolin Wang <baolin.wang7@gmail.com>
>
> Which platform did you test this on?

I tested on our Spreadtrum platform for the common sdhci driver
modification, but our host controller can not support external DMA, so
I can not help to test the external DMA.
