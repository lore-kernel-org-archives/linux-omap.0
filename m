From: "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/7] ARM: OMAP2+: Remove legacy data from hwmod for omap3
	isp iommu
Date: Mon, 23 Dec 2013 13:08:57 -0600
Message-ID: <52B88A49.9020402@ti.com>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
	<1387284818-28739-7-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1387284818-28739-7-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Florian,

On 12/17/2013 06:53 AM, Florian Vaussard wrote:
> The data are now passed using the devicetree.

Patch is good by itself. A similar change is needed for the IVA
MMU as well.

regards
Suman

>
> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 0477131..6dccd46 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -2469,15 +2469,8 @@ static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
>
>   /* mmu isp */
>
> -static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
> -	.da_start	= 0x0,
> -	.da_end		= 0xfffff000,
> -	.nr_tlb_entries = 8,
> -};
> -
>   static struct omap_hwmod omap3xxx_mmu_isp_hwmod;
>
> -
>   /* l4_core -> mmu isp */
>   static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmu_isp = {
>   	.master		= &omap3xxx_l4_core_hwmod,
> @@ -2489,7 +2482,6 @@ static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
>   	.name		= "mmu_isp",
>   	.class		= &omap3xxx_mmu_hwmod_class,
>   	.main_clk	= "cam_ick",
> -	.dev_attr	= &mmu_isp_dev_attr,
>   	.flags		= HWMOD_NO_IDLEST,
>   };
>
>
