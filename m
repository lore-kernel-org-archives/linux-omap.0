From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] usb: phy: twl4030: make runtime pm more reliable.
Date: Mon, 2 Mar 2015 22:03:59 +0100
Message-ID: <20150302210359.GG13270@amd>
References: <20150224033730.31400.78200.stgit@notabene.brown>
 <20150224034036.31400.6133.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224034036.31400.6133.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> +		status_changed =
> +			(twl->linkstat == OMAP_MUSB_VBUS_VALID ||
> +			 twl->linkstat == OMAP_MUSB_ID_GROUND)
> +			!=
> +			(status == OMAP_MUSB_VBUS_VALID ||
> +			 status == OMAP_MUSB_ID_GROUND);
>  		twl->linkstat = status;
...
> @@ -768,6 +770,10 @@ static int twl4030_usb_remove(struct platform_device *pdev)
>  
>  	/* disable complete OTG block */
>  	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
> +
> +	if (twl->linkstat == OMAP_MUSB_VBUS_VALID ||
> +	    twl->linkstat == OMAP_MUSB_ID_GROUND)
> +		pm_runtime_put_noidle(twl->dev);
>  	pm_runtime_mark_last_busy(twl->dev);

inline function returning (x == OMAP_MUSB_VBUS_VALID || x ==
OMAP_MUSB_ID_GROUND) would really help readability here.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
