From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/4]  Low-level initialization for hsmmc controller on
 LogicPD's OMAP3 SOM and TORPEDO dev kits
Date: Wed, 11 Aug 2010 20:25:32 +0300
Message-ID: <20100811172532.GB21391@nokia.com>
References: <1281544297-18015-1-git-send-email-Jacob.Tanenbaum@logicpd.com>
 <1281544297-18015-2-git-send-email-Jacob.Tanenbaum@logicpd.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1281544297-18015-2-git-send-email-Jacob.Tanenbaum@logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Aug 11, 2010 at 06:31:35PM +0200, ext Jacob Tanenbaum wrote:
>+#define OMAP3_TORPEDO_MMC_GPIO_WP               (-EINVAL)

this one isn't used anywhere, why adding it ?

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

>+	} else {
>+		printk(KERN_ERR "%s(): unknown machine type\n", __func__);
>+	return;

indentation is wrong.

>+	omap2_hsmmc_init(board_mmc_info);
>+	/* link regulators to MMC adapters */
>+	omap3logic_vmmc1_supply.dev = board_mmc_info[0].dev;
>+}
>+
>+
>+

one blank line only.

> 	/* Ensure SDRC pins are mux'd for self-refresh */
>-/*	omap_cfg_reg(H16_34XX_SDRC_CKE0);
>-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
>-	omap_cfg_reg(SDRC_CKE0);
>-	omap_cfg_reg(SDRC_CKE1); */

this shouldn't even be here in the first place. :-)

-- 
balbi

DefectiveByDesign.org
