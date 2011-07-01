From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 2/7] OMAP4: ID: add omap_has_feature for max freq
 supported
Date: Thu, 30 Jun 2011 19:41:28 -0700
Message-ID: <20110701024128.GA32673@google.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>
 <1309486081-8257-2-git-send-email-rnayak@ti.com>
 <1309486081-8257-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:16788 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab1GAClx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 22:41:53 -0400
Content-Disposition: inline
In-Reply-To: <1309486081-8257-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Aneesh V <aneesh@ti.com>, Nishanth Menon <nm@ti.com>

On Fri, Jul 01, 2011 at 07:37:56AM +0530, Rajendra Nayak wrote:
> From: Aneesh V <aneesh@ti.com>
> 
> Macros for identifying the max frequency supported by various
> OMAP4 variants - Expanding along the lines of OMAP3's feature
> handling.
> 
> [nm@ti.com: minor fixes for checks that should only for 443x|446x]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |   29 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/cpu.h |   19 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 3d43d64..a86d0f9 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -32,6 +32,7 @@ static struct omap_chip_id omap_chip;
>  static unsigned int omap_revision;
>  
>  u32 omap3_features;
> +u32 omap4_features;

Since the features are enabled by cpu_is*, need to have separate masks
for OMAP3 vs. OMAP4 in same kernel?

>  
>  unsigned int omap_rev(void)
>  {
> @@ -212,6 +213,33 @@ static void __init omap3_check_features(void)
>  	 */
>  }
>  
> +static void __init omap4_check_features(void)
> +{
> +	u32 si_type;
> +
> +	omap4_features = 0;

Already guaranteed to be zero, could skip this.

> +
> +	if (cpu_is_omap443x())
> +		omap4_features |= OMAP4_HAS_MPU_1GHZ;
> +
> +
> +	if (cpu_is_omap446x()) {
> +		si_type =
> +			read_tap_reg(OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1);
> +		switch ((si_type & (3 << 16)) >> 16) {
> +		case 2:
> +			/* High performance device */
> +			omap4_features |= OMAP4_HAS_MPU_1_5GHZ;
> +			break;

Should this fall through to also add OMAP4_HAS_MPU_1_2GHZ?  (Or are
they mutually exclusive, or 1.5 implies 1.2 also present by
convention)?


Todd
