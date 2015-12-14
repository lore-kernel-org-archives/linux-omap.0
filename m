From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V02 3/5] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Mon, 14 Dec 2015 22:39:38 +0200
Message-ID: <566F290A.2060300@ti.com>
References: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
 <1450092140-31602-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450092140-31602-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 12/14/2015 01:22 PM, Peter Ujfalusi wrote:

>  /**
> + * struct dma_slave_map - associates slave device and it's slave cha=
nnel with
> + * parameter to be used by a filter function
> + * @devname: name of the device
> + * @slave: slave channel name
> + * @param: opaque parameter to pass to struct dma_filter.fn
> + */
> +struct dma_slave_map {
> +        const char *devname;
> +        const char *slave;
> +        void *param;

??? Tabs got replaced by spaces ???

> +};
> +
> +/**
> + * struct dma_filter - information for slave device/channel to filte=
r_fn/param
> + * mapping
> + * @fn: filter function callback
> + * @mapcnt: number of slave device/channel in the map
> + * @map: array of channel to filter mapping data
> + */
> +struct dma_filter {
> +        dma_filter_fn fn;
> +        int mapcnt;
> +        const struct dma_slave_map *map;

Here also.

--=20
P=E9ter
