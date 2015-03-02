From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4] usb: phy: twl4030: allow charger to see usb current
 draw limits.
Date: Mon, 2 Mar 2015 22:03:55 +0100
Message-ID: <20150302210355.GF13270@amd>
References: <20150224033730.31400.78200.stgit@notabene.brown>
 <20150224034037.31400.26595.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224034037.31400.26595.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 14:40:37, NeilBrown wrote:
> The charger needs to know when a USB gadget has been enumerated
> and what the agreed maximum current was so that it can adjust
> charging accordingly.
> 
> So define a "set_power()" function to record the permitted
> draw, and pass a pointer to that when sending USB_EVENT_ENUMERATED
> notification.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/phy/phy-twl4030-usb.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
> index 97c59074233f..023fe150c7a1 100644
> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -163,6 +163,11 @@ struct twl4030_usb {
>  	enum omap_musb_vbus_id_status linkstat;
>  	bool			vbus_supplied;
>  
> +	/* Permitted vbus draw - only meaningful after

add "in mA"?

> +	 * USB_EVENT_ENUMERATED
> +	 */
> +	unsigned		vbus_draw;
> +
>  	struct delayed_work	id_workaround_work;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
