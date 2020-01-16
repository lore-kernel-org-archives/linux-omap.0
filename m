From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 00/10] Port am335x and am437x devices to sdhci-omap
Date: Thu, 16 Jan 2020 16:37:30 +0100
Message-ID: <CAPDyKFpaFgqRXbO-ezqVDqBM6MCbR884iz4oDCHvPvA5ML_D=A@mail.gmail.com>
References: <20200116105154.7685-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116105154.7685-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 16 Jan 2020 at 11:50, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following add driver patches for porting TI's am335x and am437x devices to
> the sdhci-omap driver.
>
> Patches 1-4 Add Support for external DMA to the sdhci driver.
>
> Patches 5-7 refactor the sdhci_set_timeout() function and use it disable
> data timeout interrupt for erase commands
>
> Patches 8-9 add new compatibles for am335x and am43xx devices to the
> sdhci-omap driver.
>
> Patch 10 implements special reset required for am335x and am437x
> devices.
>
> DT changes will be posted as a separate series.
>
> Tested on: am335x-evm, am335x-boneblack, am335x-bonegreen-wireless,
> am335x-sk, am335x-bone, am437x-idk, am43xx-gp-evm, am43xx-epos-evm.
>
> v5:
> 1. Patch 3 now uses the dma_submit_error() API instead of checking the
>    cookie on its own.
> 2. Dropped the patch adding ti,needs-special-reset property to
>    sdhci-omap. Using a flag in the driver instead.
> 3. Minor spacing changes.

Applied for next, thanks!

[...]

Kind regards
Uffe
