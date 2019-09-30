From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 linux-next 4/4] arm64: configs: defconfig: Change
 CONFIG_REMOTEPROC from m to y
Date: Mon, 30 Sep 2019 14:48:57 +0100
Message-ID: <20190930134856.umdoeq7k6ukmajij@willie-the-truck>
References: <20190920075946.13282-1-j-keerthy@ti.com>
 <20190920075946.13282-5-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190920075946.13282-5-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: arnd@arndb.de, nsekhar@ti.com, olof@lixom.net, t-kristo@ti.com, catalin.marinas@arm.com, tony@atomide.com, s-anna@ti.com, hch@lst.de, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 20, 2019 at 01:29:46PM +0530, Keerthy wrote:
> Commit 6334150e9a36 ("remoteproc: don't allow modular build")
> changes CONFIG_REMOTEPROC to a boolean from a tristate config
> option which inhibits all defconfigs marking CONFIG_REMOTEPROC as
> a module in compiling the remoteproc and dependent config options.
> 
> So fix the defconfig to have CONFIG_REMOTEPROC built in.
> 
> Fixes: 6334150e9a36 ("remoteproc: don't allow modular build")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8e05c39eab08..c9a867ac32d4 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -723,7 +723,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_ARM_SMMU=y
>  CONFIG_ARM_SMMU_V3=y
>  CONFIG_QCOM_IOMMU=y
> -CONFIG_REMOTEPROC=m
> +CONFIG_REMOTEPROC=y
>  CONFIG_QCOM_Q6V5_MSS=m
>  CONFIG_QCOM_Q6V5_PAS=m
>  CONFIG_QCOM_SYSMON=m

Acked-by: Will Deacon <will@kernel.org>

This fixes the following annoying warning from "make defconfig" on arm64:

  arch/arm64/configs/defconfig:726:warning: symbol value 'm' invalid for REMOTEPROC

I'm assuming the fix will go via arm-soc, but I can take it otherwise
(please just let me know).

Will
