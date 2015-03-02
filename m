From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] usb: phy: twl4030: add support for reading restore
 on ID pin.
Date: Mon, 2 Mar 2015 22:04:31 +0100
Message-ID: <20150302210431.GH13270@amd>
References: <20150224033730.31400.78200.stgit@notabene.brown>
 <20150224034037.31400.52748.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224034037.31400.52748.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> The twl4030 phy can measure, with low precision, the
> resistance-to-ground of the ID pin.
> 
> Add a function to read the value, and export the result
> via sysfs.
> 
> If the read fails, which it does sometimes, try again in 50msec.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/phy/phy-twl4030-usb.c |   63 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
> index 023fe150c7a1..759950898df9 100644
> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -374,6 +374,56 @@ static void twl4030_i2c_access(struct twl4030_usb *twl, int on)
>  	}
>  }
>  
> +enum twl4030_id_status {
> +	TWL4030_GROUND,
> +	TWL4030_102K,
> +	TWL4030_200K,
> +	TWL4030_440K,
> +	TWL4030_FLOATING,
> +	TWL4030_ID_UNKNOWN,
> +};
> +static char *twl4030_id_names[] = {
> +	"ground",
> +	"102k",
> +	"200k",
> +	"440k",

New /sys files should be documented somewhere...?

Does it make sense to change "440k" -> "440KOhm"?

Plus I guess you need to update Documentation/

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
