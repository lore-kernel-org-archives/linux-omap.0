From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in
	omap_uwire.c
Date: Fri, 22 Dec 2006 12:35:15 -0800
Message-ID: <20061222203514.GO2449@atomide.com>
References: <458BAF42.4000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <458BAF42.4000009@gmail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [061222 02:11]:
> 
> ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in omap_uwire.c
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

> Index: linux-osk/drivers/spi/omap_uwire.c
> ===================================================================
> --- linux-osk.orig/drivers/spi/omap_uwire.c
> +++ linux-osk/drivers/spi/omap_uwire.c
> @@ -446,7 +446,7 @@ static int uwire_setup(struct spi_device
>  	struct uwire_state *ust = spi->controller_state;
>  
>  	if (ust == NULL) {
> -		ust = kzalloc(sizeof(*ust), SLAB_KERNEL);
> +		ust = kzalloc(sizeof(*ust), GFP_KERNEL);
>  		if (ust == NULL)
>  			return -ENOMEM;
>  		spi->controller_state = ust;

Pushing today.

Tony
