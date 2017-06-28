From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 3/3] ARM: omap2plus_defconfig: enable DP83867 phy driver
Date: Wed, 28 Jun 2017 11:54:46 -0500
Message-ID: <8b0c4fb9-978b-0d67-85e2-af994f1a66e8@ti.com>
References: <cover.1498573382.git.nsekhar@ti.com>
 <3e141e778cedc0cc6168a9f9a3787a49042681c5.1498573382.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3e141e778cedc0cc6168a9f9a3787a49042681c5.1498573382.git.nsekhar@ti.com>
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
To: Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 06/27/2017 10:06 AM, Sekhar Nori wrote:
> TI's DP83867 phy is used on DRA72x EVM rev C and DRA71x
> EVMs. Enable support for it in omap2plus_defconfig.
> 
> The driver is built into the kernel to help NFS booting.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

this can go alone I think.
> ---
>   arch/arm/configs/omap2plus_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index a120ae816260..d4afa2ca2537 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -170,6 +170,7 @@ CONFIG_TI_CPTS=y
>   # CONFIG_NET_VENDOR_WIZNET is not set
>   CONFIG_AT803X_PHY=y
>   CONFIG_DP83848_PHY=y
> +CONFIG_DP83867_PHY=y
>   CONFIG_MICREL_PHY=y
>   CONFIG_SMSC_PHY=y
>   CONFIG_PPP=m
> 

-- 
regards,
-grygorii
