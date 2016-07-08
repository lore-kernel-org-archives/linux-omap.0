From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: Applied "spi: omap2-mcspi: Select SPI_SPLIT" to the spi tree
Date: Fri, 8 Jul 2016 14:24:24 +0530
Message-ID: <577F6A40.1030004@ti.com>
References: <E1bLRTH-0004lu-Mz@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1bLRTH-0004lu-Mz@finisterre>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Mark,

On Friday 08 July 2016 02:19 PM, Mark Brown wrote:
> From 2b32e987c48c65a1a40b3b4294435f761e063b6b Mon Sep 17 00:00:00 2001
> From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> Date: Thu, 7 Jul 2016 12:17:49 -0500
> Subject: [PATCH] spi: omap2-mcspi: Select SPI_SPLIT

Looks like you fixed up the description locally but forgot to fix the
subject line. It still shows SPI_SPLIT.

> 
> The function sg_split will be used by spi-omap2-mcspi to handle a SoC
> workaround in the SPI driver. Therefore, select SG_SPLIT so this function
> is available to the driver.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
