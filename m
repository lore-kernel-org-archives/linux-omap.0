From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [PATCH 5 / 12] Board 3430 SDP file
Date: Thu, 14 Jun 2007 12:30:32 +0530
Message-ID: <002601c7ae51$b4068a60$128918ac@ent.ti.com>
References: <001901c7ae50$23ba5820$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <001901c7ae50$23ba5820$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: kmpark@infradead.org, "'Syed Mohammed, Khasim'" <x0khasim@ti.com>, 'Linux OMAP' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

>To disable the wire4 mode, you should assign the value 0 instead of -1. The
>"-1" will enable the wire4 mode in the code.
Yes. Ideally it should have been set to 0.

But, note that the mmc_omap_probe you are referring here is of omap1 and
omap2(only 2420) driver. The above is a 3430 board file, so it might not
have that effect.

Regards,
Madhu


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Kyungmin
Park
Sent: Thursday, June 14, 2007 12:19 PM
To: 'Syed Mohammed, Khasim'; 'Linux OMAP'
Subject: RE: [PATCH 5 / 12] Board 3430 SDP file

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

To disable the wire4 mode, you should assign the value 0 instead of -1. The
"-1"
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


_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
