From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] usb: phy: twl4030: test ID resistance to see if
 charger is present.
Date: Mon, 2 Mar 2015 22:04:44 +0100
Message-ID: <20150302210444.GI13270@amd>
References: <20150224033730.31400.78200.stgit@notabene.brown>
 <20150224034037.31400.48003.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224034037.31400.48003.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 14:40:37, NeilBrown wrote:
> If an 'A' plug is inserted, ID should be pulled to ground.
> If a 'B' plug, then ID should be floating.
> 
> If an Accessory Charger Adapter is inserted, then ID will
> be neither grounded nor floating.  In this case tell the
> USB subsystem that it is an A plug, and the battery
> charging subsystem that it is a charger.

> Fortunately, this will treat the Openmoko charger (and
> other similar chargers) as a charger.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

I guess signed-off-by should be "real name", so I'd add a space..

Acked-by: Pavel Machek <pavel@ucw.cz>

> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -596,9 +596,31 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>  	struct twl4030_usb *twl = _twl;
>  	enum omap_musb_vbus_id_status status;
>  	bool status_changed = false;
> +	bool found_charger = false;
>  
>  	status = twl4030_usb_linkstat(twl);
>  
> +	if (status == OMAP_MUSB_ID_GROUND ||
> +	    status == OMAP_MUSB_VBUS_VALID) {
> +		/* We should check the resistance on the ID pin.
> +		 * If not a Ground or Floating, then this is
> +		 * likely a charger

"charger.", and I guess kernel comments should have /* on separate line.

So it will draw .5A from the charger? 1A? 2A?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
