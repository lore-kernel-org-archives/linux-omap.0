From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/4] omap hsmmc device tree support
Date: Thu, 23 Feb 2012 17:43:18 +0530
Message-ID: <4F462D5E.5010600@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1329998490-27555-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

On Thursday 23 February 2012 05:31 PM, Rajendra Nayak wrote:
> This series adds device tree support for OMAP hsmmc
> driver. The series is dependent on a couple other series,
> to add TWL regulator DT support[1] and another to clean
> the pdev->id usage within the hsmmc driver[2]
>
> all patches including the dependent series can be
> found here
> git://gitorious.org/omap-pm/linux.git for-dt/regulator

sorry, the right branch is for-dt/mmc

>
> The series is tested on omap4sdp (both external and emmc),
> omap4panda amd omap3beagle boards.
>
> Things to do:
> -1- Card detect isn't functional and needs twl4030 gpio
> to be DT converted.
> -2- pbias cell programming is missing and needs an OMAP
> control module driver.
>
> [1] http://marc.info/?l=linux-omap&m=132999699905180&w=2
> [2] http://marc.info/?l=linux-omap&m=132999646604985&w=2
>
> Rajendra Nayak (4):
>    mmc: omap_hsmmc: Convert hsmmc driver to use device tree
>    mmc: omap_hsmmc: Avoid a regulator voltage change with dt
>    arm/dts: OMAP4: Add mmc controller nodes and board data
>    arm/dts: OMAP3: Add mmc controller nodes and board data
>
>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   31 +++++++
>   arch/arm/boot/dts/omap3-beagle.dts                 |    6 ++
>   arch/arm/boot/dts/omap3.dtsi                       |   26 ++++++
>   arch/arm/boot/dts/omap4-panda.dts                  |   10 +++
>   arch/arm/boot/dts/omap4-sdp.dts                    |   16 ++++
>   arch/arm/boot/dts/omap4.dtsi                       |   31 +++++++
>   drivers/mmc/host/omap_hsmmc.c                      |   83 +++++++++++++++++++-
>   7 files changed, 202 insertions(+), 1 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>

