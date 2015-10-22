From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] Cleanup legacy OMAP IOMMU device creation
Date: Thu, 22 Oct 2015 12:15:55 -0500
Message-ID: <562919CB.1000606@ti.com>
References: <1442447302-5246-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442447302-5246-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 09/16/2015 06:48 PM, Suman Anna wrote:
> Hi Tony,
> 
> The following series removes the legacy platform device creation
> logic for OMAP IOMMU devices. I will cleanup the legacy support
> from the OMAP IOMMU driver in a subsequent merge window after
> this series makes it to mainline.
> 
> Patches are based on 4.3-rc1 + the OMAP3 ISP instantiation cleanup
> patch [1]. All the patches need to be picked up sequentially,
> otherwise a NULL pointer dereference crash might be seen on OMAP3
> legacy boots as the dev attribute structure is deferenced directly
> in mach-omap2/omap-iommu.c during platform data creation. Also, the
> last patch removes the structure definition altogether, so will
> cause build issues if picked separately from the hwmod cleanup
> patches.
> 
> I do not have any boards where I can still perform a legacy-style
> boot, so patches verified using DT-boot only.
> 
> regards
> Suman
> 
> [1] https://patchwork.kernel.org/patch/6806891/
> 
> Suman Anna (4):
>   ARM: OMAP2+: Remove legacy device instantiation of IOMMUs
>   ARM: OMAP3: hwmod data: Remove legacy IOMMU data
>   ARM: OMAP4: hwmod data: Remove legacy IOMMU attr and addrs
>   ARM: OMAP2+: Remove omap_mmu_dev_attr structure

Ping on this series. You should be able to pick up atleast patch 1 if
not picking all, now that the OMAP3 ISP cleanup patch is staged in your
omap-for-4.4/cleanup branch.

Thanks
Suman

> 
>  arch/arm/mach-omap2/omap-iommu.c           | 66 ------------------------------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 42 -------------------
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 31 --------------
>  include/linux/platform_data/iommu-omap.h   |  9 ----
>  4 files changed, 148 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/omap-iommu.c
> 
