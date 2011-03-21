From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
Date: Mon, 21 Mar 2011 17:28:59 +0300
Message-ID: <4D8760AB.1080307@ru.mvista.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com> <1300715420-25602-3-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300715420-25602-3-git-send-email-kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Kalle Jokiniemi wrote:

> This patch allows the ISP1707 USB tranceiver on Nokia
> N900 to be disabled when usb cable is disconnected.
> This saves approximately 14mA of battery current.

> Patch based on work done by Heikki Krogerus on N900
> maemo kernel.

> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   32 ++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index e75e240..9dd22bc 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
[...]
> @@ -534,8 +537,36 @@ static struct twl4030_gpio_platform_data rx51_gpio_data = {
>  	.setup			= rx51_twlgpio_setup,
>  };
>  
> +static void __init rx51_xceiv_init(void)
> +{
> +	if (gpio_request(RX51_USB_TRANSCEIVER_RST_GPIO, NULL) < 0)
> +		BUG();

    Why not:

	BUG_ON(gpio_request(RX51_USB_TRANSCEIVER_RST_GPIO, NULL) < 0);

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
