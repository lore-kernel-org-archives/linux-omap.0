From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix SoC detection of OMAP36/37 Family
Date: Fri, 20 Jan 2017 10:14:07 -0800
Message-ID: <20170120181407.GC7403@atomide.com>
References: <1484930641-18566-1-git-send-email-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484930641-18566-1-git-send-email-aford173@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: aford173@gmail.com
Cc: linux-omap@vger.kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* aford173@gmail.com <aford173@gmail.com> [170120 08:45]:
> From: Adam Ford <aford173@gmail.com>
> 
> The OMAP36/37 families are similar, but there are a few features sections
> that can help identify some of them.  Let's add checks for 3630/3730,
> OMAP3621, DM3725, OMAP3615/DM3715, OMAP3611, and AM3703 all based on
> features similar to what was done for the OMAP34xx/35xx series
> 
> The checkpatch flags some warnings for braces, but I kept the coding style
> to match the adjacent code for consistency.
> 
> I don't have an OMAP36xx to test, but this was tested on both a DM3730 and
> AM3703.

AFAIK 3630 is exactly the same as dm3730. Applying into
omap-for-v4.11/fixes-not-urgent thanks.

Regards,

Tony

> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index cc6d9fa..e2274a1 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -223,7 +223,15 @@ static void __init omap3_cpuinfo(void)
>  	 * and CPU class bits.
>  	 */
>  	if (soc_is_omap3630()) {
> -		cpu_name = "OMAP3630";
> +		if (omap3_has_iva() && omap3_has_sgx()) {
> +			cpu_name = (omap3_has_isp()) ? "OMAP3630/DM3730" : "OMAP3621";
> +		} else if (omap3_has_iva()) {
> +			cpu_name = "DM3725";
> +		} else if (omap3_has_sgx()) {
> +			cpu_name = "OMAP3615/AM3715";
> +		} else {
> +			cpu_name = (omap3_has_isp()) ? "AM3703" : "OMAP3611";
> +		}
>  	} else if (soc_is_am35xx()) {
>  		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
>  	} else if (soc_is_ti816x()) {
> -- 
> 2.7.4
> 
