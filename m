From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Register the OPP table only for 4430
 device
Date: Wed, 08 Aug 2012 10:18:48 -0700
Message-ID: <87628twbd3.fsf@ti.com>
References: <1344423254-3475-1-git-send-email-rnayak@ti.com>
 <1344423254-3475-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1344423254-3475-3-git-send-email-rnayak@ti.com> (Rajendra
 Nayak's message of "Wed, 8 Aug 2012 16:24:14 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> The 4430 OPP table was being registered for all other OMAP4 variants
> too, like 4460 and 4470 causing issues with cpufreq driver
> enabled. 4460 and 4470 devices have different OPPs as compared to
> 4430, and they should be populated seperately. As long as that
> happens, let the OPP table registeration happen only on 4430 device.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, adding to PM fixes for v3.6-rc (branch: for_3.6/fixes/pm)

Kevin

> ---
>  arch/arm/mach-omap2/opp4xxx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index 2293ba2..c95415d 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -94,7 +94,7 @@ int __init omap4_opp_init(void)
>  {
>  	int r = -ENODEV;
>  
> -	if (!cpu_is_omap44xx())
> +	if (!cpu_is_omap443x())
>  		return r;
>  
>  	r = omap_init_opp_table(omap44xx_opp_def_list,
