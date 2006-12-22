From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in
	ads7846.c
Date: Fri, 22 Dec 2006 12:34:48 -0800
Message-ID: <20061222203448.GN2449@atomide.com>
References: <458BAEEA.1010402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <458BAEEA.1010402@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061222 02:10]:
> 
> ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in ads7846.c
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

> Index: linux-osk/drivers/input/touchscreen/ads7846.c
> ===================================================================
> --- linux-osk.orig/drivers/input/touchscreen/ads7846.c
> +++ linux-osk/drivers/input/touchscreen/ads7846.c
> @@ -201,7 +201,7 @@ static int ads7846_read12_ser(struct dev
>  {
>  	struct spi_device	*spi = to_spi_device(dev);
>  	struct ads7846		*ts = dev_get_drvdata(dev);
> -	struct ser_req		*req = kzalloc(sizeof *req, SLAB_KERNEL);
> +	struct ser_req		*req = kzalloc(sizeof *req, GFP_KERNEL);
>  	int			status;
>  	int			sample;
>  	int			use_internal;

Pushing today.

Tony
