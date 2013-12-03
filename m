From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] omap: twl-common: Fix musb-hdrc device name.
Date: Tue, 3 Dec 2013 14:28:43 +0530
Message-ID: <529D9D43.6040101@ti.com>
References: <1386059589-4030-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386059589-4030-1-git-send-email-marek.belisko@open-nandra.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Belisko <marek.belisko@open-nandra.com>, tony@atomide.com, linux@arm.linux.org.uk
Cc: hns@goldelico.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 03 December 2013 02:03 PM, Marek Belisko wrote:
> Without this change when booting omap3 device (gta04) with board file
> leads to follwing errors:
> 
> [    1.203308] musb-hdrc musb-hdrc.0.auto: unable to find phy
> [    1.209075] HS USB OTG: no transceiver configured
> [    1.214019] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
> 
> and usb isn't working.
> 
> This is probably regression caused by commit: 6c27f939

I think a better fix would be to have this merged..
https://lkml.org/lkml/2013/7/26/91
> 
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> ---
>  arch/arm/mach-omap2/twl-common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index b0d54da..3640ce0 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -92,7 +92,7 @@ void __init omap_pmic_late_init(void)
>  
>  #if defined(CONFIG_ARCH_OMAP3)
>  struct phy_consumer consumers[] = {
> -	PHY_CONSUMER("musb-hdrc.0", "usb"),
> +	PHY_CONSUMER("musb-hdrc.0.auto", "usb"),

the index '0' might vary for some boards leading it to again break musb.

Thanks
Kishon
