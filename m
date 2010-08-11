From: "Jacob Tanenbaum" <Jacob.Tanenbaum@logicpd.com>
Subject: RE: [PATCH 2/4]  Low-level initialization for hsmmc controller on LogicPD's OMAP3 SOM and TORPEDO dev kits
Date: Wed, 11 Aug 2010 13:47:24 -0500
Message-ID: <77A0A4DB5BF2A44283E5522C27234AC6021C82BC@EDPRSRV011.logicpd.com>
References: <20100811172532.GB21391@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:1623 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754982Ab0HKSr0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 14:47:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20100811172532.GB21391@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, tony@atomide.com



-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
Sent: Wednesday, August 11, 2010 1:26 PM
To: Jacob Tanenbaum
Cc: linux@arm.linux.org.uk; linux-omap@vger.kernel.org;
linux-kernel@vger.kernel.org; rmk@arm.linux.org.uk; tony@atomide.com
Subject: Re: [PATCH 2/4] Low-level initialization for hsmmc controller
on LogicPD's OMAP3 SOM and TORPEDO dev kits

Hi,

On Wed, Aug 11, 2010 at 06:31:35PM +0200, ext Jacob Tanenbaum wrote:
>+#define OMAP3_TORPEDO_MMC_GPIO_WP               (-EINVAL)

this one isn't used anywhere, why adding it ?

will fix

>+static struct regulator_init_data omap3logic_vmmc1 = {
>+	.constraints = {
>+		.name			= "VMMC1",
>+		.min_uV			= 1850000,
>+		.max_uV			= 3150000,
>+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
>+					| REGULATOR_MODE_STANDBY,
>+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
>+					| REGULATOR_CHANGE_MODE
>+					| REGULATOR_CHANGE_STATUS,
>+	},
>+	.num_consumer_supplies  = 1,
>+	.consumer_supplies      = &omap3logic_vmmc1_supply,
>+};
>+
>+
>+

one blank line only.

Will fix 

>+	} else {
>+		printk(KERN_ERR "%s(): unknown machine type\n",
__func__);
>+	return;

indentation is wrong.

Will fix

>+	omap2_hsmmc_init(board_mmc_info);
>+	/* link regulators to MMC adapters */
>+	omap3logic_vmmc1_supply.dev = board_mmc_info[0].dev;
>+}
>+
>+
>+

one blank line only.

Will fix

> 	/* Ensure SDRC pins are mux'd for self-refresh */
>-/*	omap_cfg_reg(H16_34XX_SDRC_CKE0);
>-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
>-	omap_cfg_reg(SDRC_CKE0);
>-	omap_cfg_reg(SDRC_CKE1); */

this shouldn't even be here in the first place. :-)

I removed this code and made a mistake in the rebase, it is removed in
patch 4 will fix

-- 
balbi

DefectiveByDesign.org
