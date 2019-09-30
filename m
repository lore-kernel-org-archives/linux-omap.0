From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 linux-next 2/4] arm: configs: davinci_all_defconfig:
 Change CONFIG_REMOTEPROC from m to y
Date: Mon, 30 Sep 2019 20:39:58 +0530
Message-ID: <e48c767f-6153-a8d5-b88d-f74927921ae2@ti.com>
References: <20190920075946.13282-1-j-keerthy@ti.com>
 <20190920075946.13282-3-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190920075946.13282-3-j-keerthy@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>, arnd@arndb.de, olof@lixom.net, t-kristo@ti.com, catalin.marinas@arm.com, will@kernel.org, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, linux-omap@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 20/09/19 1:29 PM, Keerthy wrote:
> Commit 6334150e9a36 ("remoteproc: don't allow modular build")
> changes CONFIG_REMOTEPROC to a boolean from a tristate config
> option which inhibits all defconfigs marking CONFIG_REMOTEPROC as
> a module in compiling the remoteproc and dependent config options.
> 
> So fix the davinci_all_defconfig to have CONFIG_REMOTEPROC built in.
> 
> Fixes: 6334150e9a36 ("remoteproc: don't allow modular build")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/configs/davinci_all_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> index b34970ce6b31..01e3c0f4be92 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -228,7 +228,7 @@ CONFIG_RTC_DRV_OMAP=m
>  CONFIG_DMADEVICES=y
>  CONFIG_TI_EDMA=y
>  CONFIG_COMMON_CLK_PWM=m
> -CONFIG_REMOTEPROC=m
> +CONFIG_REMOTEPROC=y

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
