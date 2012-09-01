From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCHv3 9/9] ir-rx51: Add missing quote mark in Kconfig text
Date: Sat, 1 Sep 2012 20:16:50 +0300
Message-ID: <20120901171650.GD6638@valkosipuli.retiisi.org.uk>
References: <1346349271-28073-1-git-send-email-timo.t.kokkonen@iki.fi>
 <1346349271-28073-10-git-send-email-timo.t.kokkonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346349271-28073-10-git-send-email-timo.t.kokkonen@iki.fi>
Sender: linux-media-owner@vger.kernel.org
To: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Moi,

On Thu, Aug 30, 2012 at 08:54:31PM +0300, Timo Kokkonen wrote:
> This trivial fix cures the following warning message:
> 
> drivers/media/rc/Kconfig:275:warning: multi-line strings not supported
> 
> Signed-off-by: Timo Kokkonen <timo.t.kokkonen@iki.fi>
> ---
>  drivers/media/rc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
> index 4a68014..1300655 100644
> --- a/drivers/media/rc/Kconfig
> +++ b/drivers/media/rc/Kconfig
> @@ -272,7 +272,7 @@ config IR_IGUANA
>  	   be called iguanair.
>  
>  config IR_RX51
> -	tristate "Nokia N900 IR transmitter diode
> +	tristate "Nokia N900 IR transmitter diode"
>  	depends on OMAP_DM_TIMER && LIRC
>  	---help---
>  	   Say Y or M here if you want to enable support for the IR

This should be combined with patch 1.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
