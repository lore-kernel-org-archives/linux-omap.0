From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit
 definitions
Date: Fri, 17 Feb 2012 14:37:34 +0100
Message-ID: <4F3E581E.1050009@ti.com>
References: <1329477961-1307-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1329477961-1307-1-git-send-email-hvaibhav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: khilman@ti.com, paul@pwsan.com, tony@atomide.com, thara@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2/17/2012 12:26 PM, Vaibhav Hiremath wrote:
> In the SYSC_TYPE1_XXX_MASK configuration, SYSC_XXX_SHIFT macro
> is used which is not defined anywhere in the kernel.
> Until now the build was going through successfully, since it
> is not being used anywhere in kernel.

Good catch.

> This bug got introduced by the commit
> 358f0e630d5409ab3837b86db3595560eae773b6 ("OMAP3: hwmod: support
> to specify the offset position of various SYSCONFIG register bits.")
>
> Signed-off-by: Vaibhav Hiremath<hvaibhav@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit


> ---
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |   12 ++++++------
>   1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index dbc18ad..55bef2b 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -49,17 +49,17 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type4;
>    * with the original PRCM protocol defined for OMAP2420
>    */
>   #define SYSC_TYPE1_MIDLEMODE_SHIFT	12
> -#define SYSC_TYPE1_MIDLEMODE_MASK	(0x3<<  SYSC_MIDLEMODE_SHIFT)
> +#define SYSC_TYPE1_MIDLEMODE_MASK	(0x3<<  SYSC_TYPE1_MIDLEMODE_SHIFT)
>   #define SYSC_TYPE1_CLOCKACTIVITY_SHIFT	8
> -#define SYSC_TYPE1_CLOCKACTIVITY_MASK	(0x3<<  SYSC_CLOCKACTIVITY_SHIFT)
> +#define SYSC_TYPE1_CLOCKACTIVITY_MASK	(0x3<<  SYSC_TYPE1_CLOCKACTIVITY_SHIFT)
>   #define SYSC_TYPE1_SIDLEMODE_SHIFT	3
> -#define SYSC_TYPE1_SIDLEMODE_MASK	(0x3<<  SYSC_SIDLEMODE_SHIFT)
> +#define SYSC_TYPE1_SIDLEMODE_MASK	(0x3<<  SYSC_TYPE1_SIDLEMODE_SHIFT)
>   #define SYSC_TYPE1_ENAWAKEUP_SHIFT	2
> -#define SYSC_TYPE1_ENAWAKEUP_MASK	(1<<  SYSC_ENAWAKEUP_SHIFT)
> +#define SYSC_TYPE1_ENAWAKEUP_MASK	(1<<  SYSC_TYPE1_ENAWAKEUP_SHIFT)
>   #define SYSC_TYPE1_SOFTRESET_SHIFT	1
> -#define SYSC_TYPE1_SOFTRESET_MASK	(1<<  SYSC_SOFTRESET_SHIFT)
> +#define SYSC_TYPE1_SOFTRESET_MASK	(1<<  SYSC_TYPE1_SOFTRESET_SHIFT)
>   #define SYSC_TYPE1_AUTOIDLE_SHIFT	0
> -#define SYSC_TYPE1_AUTOIDLE_MASK	(1<<  SYSC_AUTOIDLE_SHIFT)
> +#define SYSC_TYPE1_AUTOIDLE_MASK	(1<<  SYSC_TYPE1_AUTOIDLE_SHIFT)
>
>   /*
>    * OCP SYSCONFIG bit shifts/masks TYPE2. These are for IPs compliant
> --
> 1.7.0.4
>
