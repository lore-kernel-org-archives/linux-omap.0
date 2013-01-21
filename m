From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] usb: musb: fix context save over suspend.
Date: Mon, 21 Jan 2013 13:38:59 +0200
Message-ID: <50FD28D3.5070107@compulab.co.il>
References: <20130121202831.40a09bbc@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130121202831.40a09bbc@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Neil,

On 01/21/13 11:28, NeilBrown wrote:
> 
> 
> The standard suspend sequence involves runtime_resuming
> devices before suspending the system.
> So just saving context in runtime_suspend and restoring it
> in runtime resume isn't enough.  We  must also save in "suspend"
> and restore in "resume".
> 
> Without this patch, and OMAP3 system with off_mode enabled will find
> the musb port non-functional after suspend/resume.  With the patch it
> works perfectly.

Hmmm... Some time ago, this has been removed in
5d193ce8 (usb: musb: PM: fix context save/restore in suspend/resume path)

Am I missing something? Or things changed and now this patch is correct?

> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index fd34867..b6ccc02 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2225,6 +2225,7 @@ static int musb_suspend(struct device *dev)
>  	}
>  
>  	spin_unlock_irqrestore(&musb->lock, flags);
> +	musb_save_context(musb);
>  	return 0;
>  }
>  
> @@ -2234,6 +2235,8 @@ static int musb_resume_noirq(struct device *dev)
>  	 * unless for some reason the whole soc powered down or the USB
>  	 * module got reset through the PSC (vs just being disabled).
>  	 */
> +	struct musb	*musb = dev_to_musb(dev);
> +	musb_restore_context(musb);
>  	return 0;
>  }
>  

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQ/SjTAAoJEBDE8YO64EfaHrsP/2bl4rP6L/tWLSZ+rNEdz6B+
Qo+HVOhnTVsOxgWbbd5VrfhE28jLoFGMslrLuI+geeCcJ1zgwNsahG9C11bygyfu
54hQgkmaxDJPDKAlalcy7VK9C6tOTgQV5iSbuRlemttK879dTrb+33zP6idn5+zK
kxptY38fpmyojnl8gJiVa6Plik/apQcVr+GIx8CMwj+YQC5vkdg7cUEWyngfyk2C
W0U4NceroS8NSjRbcFV3V6Q912TVjKzl+B2yxVD0OBaSK4BpHEncDBXiVx8APq87
4nDeBB5gDXi1rtN3YjcfDaFu0me5qzpYc3JFFidvdLTdXIdvxDzjHgMqsZB8ZBYC
R0e5PtIw/62I90d63JkXZXVRTB7JeZsGfZFY2R7MxBab9or8zz0OyYwGWoW63vzH
oFrwmAkWoD0IEKcfc8+dd99eicgZrmQL6FDWrEMsX+RS34LRtVU30SVAudRhY+CR
MhNCjKyFySwx7wqkGgJl1ECl0Y6U4ua0v4bv7kdE6eyrgbQIkiGliSJ7DhWBPcP6
iMIOTwC7+LwPYP/MX2uYR3DXDfI0XwiqdtyzhD9LJe4PRol8zjozS2j0Y7FriItw
jFqsgCgwDc9j8ufcpXf5ZynJYnlCG0iLuAPEUugZot83/CpxgU++A8cuHqUrOnhH
76L95rflUTkpiQ76ffP7
=jqXb
-----END PGP SIGNATURE-----
