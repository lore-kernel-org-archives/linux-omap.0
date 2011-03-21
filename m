From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] USB: twl4030-usb: do board specific phy_power up/down
Date: Mon, 21 Mar 2011 17:21:26 +0300
Message-ID: <4D875EE6.50505@ru.mvista.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com> <1300715420-25602-2-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300715420-25602-2-git-send-email-kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Kalle Jokiniemi wrote:

> In case some board has special powering sequences for
> the USB tranceiver, call those during __twl4030_phy_power
> calls.

> This is a preparation patch to allow powering down the
> ISP1707 USB serial tranceiver in Nokia N900.

> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/otg/twl4030-usb.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> index 6ca505f..dea99b1 100644
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -348,13 +348,20 @@ static void twl4030_i2c_access(struct twl4030_usb *twl, int on)
>  
>  static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
>  {
> -	u8 pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
> +	u8 pwr;

    Why change this line? Also, some prefer that initialized variables precede 
uninitialized ones...

> +	struct twl4030_usb_data *board = twl->dev->platform_data;
> +
> +	pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
>  
>  	if (on)
>  		pwr &= ~PHY_PWR_PHYPWD;
>  	else
>  		pwr |= PHY_PWR_PHYPWD;
>  
> +	/* do board specific power up/down, if available */
> +	if (board->phy_power)
> +		board->phy_power(twl->dev, 0, on);
> +
>  	WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
>  }

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
