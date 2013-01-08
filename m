From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 03/18] memory: emif: Move EMIF related header file to
 include/linux/
Date: Tue, 8 Jan 2013 19:34:41 +0530
Message-ID: <50EC2779.8030507@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-4-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34404 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756190Ab3AHODt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 09:03:49 -0500
In-Reply-To: <1356959231-17335-4-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Aneesh V <aneesh@ti.com>

On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> OMAP4 and AM33XX share the same EMIF controller IP. Although there
> are significant differences in the IP integration due to which
> AM33XX can't reuse the EMIF driver DVFS similar to OMAP4,
> it can definitely benefit by reusing the EMIF related macros
> defined in drivers/memory/emif.h.
>
> In the current OMAP PM framework the PM code resides under
> arch/arm/mach-omap2/. To enable reuse of the register defines move
> the emif header file to include/linux so that both the EMIF driver
> and the AM33XX PM code can benefit.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Aneesh V <aneesh@ti.com>
> ---
> v1->v2:
> 	This is a new patch in the series to enable code reuse
> 	between the EMIF driver and AM33XX PM code
>
>   drivers/memory/emif.c   |    2 +-
>   drivers/memory/emif.h   |  589 -----------------------------------------------
>   include/linux/ti_emif.h |  589 +++++++++++++++++++++++++++++++++++++++++++++++
You are just moving the file. So "git mv file1 flie2; and the git 
format-patch -C"
on committed patch should just generate few lines of patch.

> +/* DDR_PHY_CTRL_1 - EMIF4D5 */
> +#define DLL_HALF_DELAY_SHIFT_4D5			21
> +#define DLL_HALF_DELAY_MASK_4D5				(1 << 21)
> +#define READ_LATENCY_SHIFT_4D5				0
> +#define READ_LATENCY_MASK_4D5				(0x1f << 0)
> +
> +/* DDR_PHY_CTRL_1_SHDW */
> +#define DDR_PHY_CTRL_1_SHDW_SHIFT			5
> +#define DDR_PHY_CTRL_1_SHDW_MASK			(0x7ffffff << 5)
> +#define READ_LATENCY_SHDW_SHIFT				0
> +#define READ_LATENCY_SHDW_MASK				(0x1f << 0)
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * Structure containing shadow of important registers in EMIF
> + * The calculation function fills in this structure to be later used for
> + * initialisation and DVFS
> + */
> +struct emif_regs {
Are you using above struct. If not we can leave it in same place and
just move the register defines.

Regards
santosh

