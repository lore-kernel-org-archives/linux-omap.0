From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/15] OMAP: DSS2: SDI driver
Date: Wed, 5 Aug 2009 17:59:39 +0300
Message-ID: <20090805145939.GR7374@atomide.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57402 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934566AbZHEO7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:59:46 -0400
Content-Disposition: inline
In-Reply-To: <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/dss/sdi.c |  370 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 370 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/sdi.c
> 
> diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
> new file mode 100644
> index 0000000..2f4d226
> --- /dev/null
> +++ b/drivers/video/omap2/dss/sdi.c
> @@ -0,0 +1,370 @@
> +/*
> + * linux/drivers/video/omap2/dss/sdi.c
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define DSS_SUBSYS_NAME "SDI"
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include <mach/board.h>
> +#include <mach/display.h>
> +#include "dss.h"
> +
> +#define CONTROL_PADCONF_BASE	0x48002000
> +
> +#define OMAP_SDI_PAD_DIS(pe, pu) ((7 << 0)		| /* MODE 7 = safe */ \
> +				 (((pe) ? 1 : 0) << 3)	| /* PULL_ENA */      \
> +				 (((pu) ? 1 : 0) << 4)	| /* PULL_UP  */      \
> +				 (1 << 8))		  /* INPUT_EN */
> +
> +#define OMAP_SDI_PAD_EN		 (1 << 0)		  /* MODE 1 = SDI_xx */
> +
> +#define OMAP_SDI_PAD_MASK	OMAP_SDI_PAD_DIS(1, 1)
> +
> +static struct {
> +	bool skip_init;
> +	bool update_enabled;
> +} sdi;
> +
> +/* CONTROL_PADCONF_DSS_DATAXX */
> +static const u16 sdi_pads[] =
> +{
> +	0x0f0,		/* 10[ 7..0]:SDI_DAT1N */
> +	0x0f2,		/* 10[15..0]:SDI_DAT1P */
> +	0x0f4,		/* 12[ 7..0]:SDI_DAT2N */
> +	0x0f6,		/* 12[15..0]:SDI_DAT2P */
> +	0x0f8,		/* 14[ 7..0]:SDI_DAT3N */
> +	0x0fa,		/* 14[15..0]:SDI_DAT3P */
> +	0x108,		/* 22[ 7..0]:SDI_CLKN */
> +	0x10a,		/* 22[15..0]:SDI_CLKP */
> +};

Aaargh, NAK for custom pin muxing. Please do it in mux.[ch], see
arch/arm/mach-omap2/mux.c.

> +
> +/*
> + * Check if bootloader / platform code has configured the SDI pads properly.
> + * This means it either configured all required pads for SDI mode, or that it
> + * left all the required pads unconfigured.
> + */
> +static int sdi_pad_init(struct omap_dss_device *dssdev)
> +{
> +	unsigned req_map;
> +	bool configured = false;
> +	bool unconfigured = false;
> +	int data_pairs;
> +	int i;
> +
> +	data_pairs = dssdev->phy.sdi.datapairs;
> +	req_map = (1 << (data_pairs * 2)) - 1;		/* data lanes */
> +	req_map |= 3 << 6;				/* clk lane */
> +	for (i = 0; i < ARRAY_SIZE(sdi_pads); i++) {
> +		u32 reg;
> +		u32 val;
> +
> +		if (!((1 << i) & req_map))
> +			/* Ignore unneded pads. */
> +			continue;
> +		reg = CONTROL_PADCONF_BASE + sdi_pads[i];
> +		val = omap_readw(reg);
> +		switch (val & 0x07) {	/* pad mode */
> +		case 1:
> +			if (unconfigured)
> +				break;
> +			/* Is the pull configuration ok for SDI mode? */
> +			if ((val & OMAP_SDI_PAD_MASK) != OMAP_SDI_PAD_EN)
> +				break;
> +			configured = true;
> +			break;
> +		case 0:
> +		case 7:
> +			if (configured)
> +				break;
> +			unconfigured = true;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	if (i != ARRAY_SIZE(sdi_pads)) {
> +		DSSERR("SDI: invalid pad configuration\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sdi_pad_config(struct omap_dss_device *dssdev, bool enable)
> +{
> +	int data_pairs;
> +	bool pad_off_pe, pad_off_pu;
> +	unsigned req_map;
> +	int i;
> +
> +	data_pairs = dssdev->phy.sdi.datapairs;
> +	pad_off_pe = dssdev->phy.sdi.pad_off_pe;
> +	pad_off_pu = dssdev->phy.sdi.pad_off_pu;
> +	req_map = (1 << (data_pairs * 2)) - 1;		/* data lanes */
> +	req_map |= 3 << 6;				/* clk lane */
> +	for (i = 0; i < ARRAY_SIZE(sdi_pads); i++) {
> +		u32 reg;
> +		u16 val;
> +
> +		if (!((1 << i) & req_map))
> +			continue;
> +		if (enable)
> +			val = OMAP_SDI_PAD_EN;
> +		else
> +			val = OMAP_SDI_PAD_DIS(pad_off_pe, pad_off_pu);
> +		reg = CONTROL_PADCONF_BASE + sdi_pads[i];
> +		omap_writew(val, reg);
> +	}
> +}
> +

Looks like you can do all this with mux.[ch]. If not, we need to improve
the generic mux code.

Regards,

Tony
