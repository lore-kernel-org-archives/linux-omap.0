From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/10] arch/arm OMAP IOMMU patches for 3.15
Date: Tue, 11 Mar 2014 16:49:10 -0500
Message-ID: <531F84D6.8070101@ti.com>
References: <1394065459-16409-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394065459-16409-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 03/05/2014 06:24 PM, Suman Anna wrote:
> Hi Paul, Benoit,
>
> This is a repost as per Tony's request [3] of all the OMAP IOMMU DT support
> patches that are under arch/arm. The series just assimilates patches 8
> through 13 from the v3 OMAP IOMMU DT adaptation for 3.15 series [1], and
> all the v2 patches from the OMAP IOMMU DTS nodes [2].
>
> The only change made with respect to the patches above is in the OMAP4
> and OMAP5 DTS nodes - I have adjusted the reg sizes from 0xff to 0x100.
>
> Can you please provide your acks on the hwmod patches and DTS
> patches?

Ping. Can you review and provide your acks for Patches 2 and 5 (the 
hwmod patches) for Tony to pick up all the patches in the series?

regards
Suman

>
> [1] http://marc.info/?l=linux-omap&m=139362022805667&w=2
> [2] http://marc.info/?l=linux-omap&m=139362062805816&w=2
> [3] http://marc.info/?l=linux-omap&m=139404802021252&w=2
>
> Florian Vaussard (4):
>    ARM: OMAP3: remove deprecated CONFIG_OMAP_IOMMU_IVA2
>    ARM: dts: OMAP3: Update ISP IOMMU node
>    ARM: dts: OMAP3: Add IVA IOMMU node
>    ARM: dts: OMAP4: Add IOMMU nodes
>
> Suman Anna (6):
>    ARM: OMAP3: fix iva mmu programming issues
>    ARM: OMAP2+: change the ISP device archdata MMU name for DT
>    ARM: OMAP2+: use pdata quirks for iommu reset lines
>    ARM: OMAP5: hwmod data: add mmu data for ipu & dsp
>    ARM: OMAP2+: extend iommu pdata-quirks to OMAP5
>    ARM: dts: OMAP5: Add IOMMU nodes
>
>   arch/arm/boot/dts/omap3.dtsi                | 15 ++++--
>   arch/arm/boot/dts/omap4.dtsi                | 15 ++++++
>   arch/arm/boot/dts/omap5.dtsi                | 15 ++++++
>   arch/arm/mach-omap2/clockdomains3xxx_data.c |  2 +-
>   arch/arm/mach-omap2/devices.c               |  3 ++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 12 ++---
>   arch/arm/mach-omap2/omap_hwmod_54xx_data.c  | 83 +++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/pdata-quirks.c          | 24 +++++++++
>   arch/arm/plat-omap/Kconfig                  |  3 --
>   9 files changed, 157 insertions(+), 15 deletions(-)
>
