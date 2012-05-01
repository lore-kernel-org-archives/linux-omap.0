From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] arm: omap3: am35x: Don't mark missing features as present
Date: Tue, 01 May 2012 07:15:19 -0700
Message-ID: <87pqaohts8.fsf@ti.com>
References: <1334861927-1741-1-git-send-email-mgreer@animalcreek.com>
	<1335830229-4700-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:36738 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753637Ab2EAOPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 10:15:21 -0400
Received: by pbcwy12 with SMTP id wy12so6252473pbc.24
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 07:15:20 -0700 (PDT)
In-Reply-To: <1335830229-4700-1-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Mon, 30 Apr 2012 16:57:09 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> The Chip Identification register on the am35x family of SoCs
> has bits 12, 7:5, and 3:2 marked as reserved and are read as
> zeroes.  Unfortunately, on other omap SoCs, a 0 bit means a
> feature is "Full Use" so the OMAP3_CHECK_FEATURE() macro
> called by omap3_check_features() will incorrectly interpret
> those zeroes to mean that a feature is present even though it
> isn't.  To fix that, the feature bits that are incorrectly
> set (namely, OMAP3_HAS_IVA and OMAP3_HAS_ISP) need to be
> cleared after all of the calls to OMAP3_CHECK_FEATURE() in
> omap3_check_features() are made.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Looks good, thanks.

I'll queue this one up on top of my AM35x cpu_is cleanups (branch:
for_3.5/cleanup/am35x-cpu-is)

Kevin

> ---
>  arch/arm/mach-omap2/id.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index d2913e2..20c95b4 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -247,6 +247,17 @@ void __init omap3xxx_check_features(void)
>  	omap_features |= OMAP3_HAS_SDRC;
>  
>  	/*
> +	 * am35x fixups:
> +	 * - The am35x Chip ID register has bits 12, 7:5, and 3:2 marked as
> +	 *   reserved and therefore return 0 when read.  Unfortunately,
> +	 *   OMAP3_CHECK_FEATURE() will interpret some of those zeroes to
> +	 *   mean that a feature is present even though it isn't so clear
> +	 *   the incorrectly set feature bits.
> +	 */
> +	if (cpu_is_am35xx())
> +		omap_features &= ~(OMAP3_HAS_IVA | OMAP3_HAS_ISP);
> +
> +	/*
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
>  	 */
