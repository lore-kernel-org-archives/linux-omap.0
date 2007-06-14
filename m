From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH 5 / 12] Board 3430 SDP file
Date: Thu, 14 Jun 2007 15:49:13 +0900
Message-ID: <001901c7ae50$23ba5820$e1ac580a@swcenter.sec.samsung.co.kr>
References: <9C23CDD79DA20A479D4615857B2E2C47011E60AD@dlee13.ent.ti.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <9C23CDD79DA20A479D4615857B2E2C47011E60AD@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Syed Mohammed, Khasim'" <x0khasim@ti.com>, 'Linux OMAP' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

> +static struct omap_mmc_config sdp3430_mmc_config __initdata = {
> +	.mmc [0] = {
> +		.enabled	= 1,
> +		.wire4		= -1,
> +		.wp_pin		= -1,
> +		.power_pin	= -1,
> +		.switch_pin	= 0,
> +	},
> +	.mmc [1] = {
> +		.enabled	= 1,
> +		.wire4		= -1,
> +		.wp_pin		= -1,
> +		.power_pin	= -1,
> +		.switch_pin	= 1,
> +	},
> +};
> +

To disable the wire4 mode, you should assign the value 0 instead of -1. The "-1"
will enable the wire4 mode in the code.

static int __init mmc_omap_probe(struct platform_device *pdev)
{
        struct omap_mmc_conf *minfo = pdev->dev.platform_data;
	...
	if (minfo->wire4)
                 mmc->caps |= MMC_CAP_4_BIT_DATA;
	...
}

Thank you,
Kyungmin Park
