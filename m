From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] arm: omap2plus_defconfig: enable NET_SWITCHDEV
Date: Fri, 6 Dec 2019 13:07:10 +0200
Message-ID: <c8058866-2be9-831c-19f6-31d17decb6f1@ti.com>
References: <20191204174533.32207-1-grygorii.strashko@ti.com>
 <20191204174533.32207-3-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204174533.32207-3-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 04/12/2019 19:45, Grygorii Strashko wrote:
> The TI_CPSW_SWITCHDEV definition in Kconfig was changed from "select
> NET_SWITCHDEV" to "depends on NET_SWITCHDEV", and therefore it is required
> to explicitelly enable NET_SWITCHDEV config option in omap2plus_defconfig.
> 
> Fixes: 3727d259ddaf ("arm: omap2plus_defconfig: enable new cpsw switchdev driver")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>   arch/arm/configs/omap2plus_defconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 89cce8d4bc6b..7bbef86a4e76 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -92,6 +92,7 @@ CONFIG_IP_PNP_BOOTP=y
>   CONFIG_IP_PNP_RARP=y
>   CONFIG_NETFILTER=y
>   CONFIG_PHONET=m
> +CONFIG_NET_SWITCHDEV=y
>   CONFIG_CAN=m
>   CONFIG_CAN_C_CAN=m
>   CONFIG_CAN_C_CAN_PLATFORM=m
> @@ -182,6 +183,7 @@ CONFIG_SMSC911X=y
>   # CONFIG_NET_VENDOR_STMICRO is not set
>   CONFIG_TI_DAVINCI_EMAC=y
>   CONFIG_TI_CPSW=y
> +CONFIG_TI_CPSW_SWITCHDEV=y
>   CONFIG_TI_CPTS=y
>   # CONFIG_NET_VENDOR_VIA is not set
>   # CONFIG_NET_VENDOR_WIZNET is not set
> @@ -554,4 +556,3 @@ CONFIG_DEBUG_INFO_DWARF4=y
>   CONFIG_MAGIC_SYSRQ=y
>   CONFIG_SCHEDSTATS=y
>   # CONFIG_DEBUG_BUGVERBOSE is not set
> -CONFIG_TI_CPSW_SWITCHDEV=y
> 

Could it be applied as fix, as without it cpsw switch driver will not be built,
so no networking on am571x-idk

-- 
Best regards,
grygorii
