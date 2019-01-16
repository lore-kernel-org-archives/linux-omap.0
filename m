From: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Wed, 16 Jan 2019 21:26:02 +0100
Message-ID: <258ecb6b-c2b2-c8b8-9804-4df69002d9f5@web.de>
References: <20190116113723.15668-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190116113723.15668-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 16.01.19 12:37, Ulf Hansson wrote:
> During "wlan-up", we are programming the FW into the WiFi-chip. However,
> re-programming the FW doesn't work, unless a power cycle of the WiFi-chi=
p
> is made in-between the programmings.
>
> To conform to this requirement and to fix the regression in a simple way=
,
> let's start by allowing that the SDIO card (WiFi-chip) may stay powered =
on
> (runtime resumed) when wl12xx_sdio_power_off() returns. The intent with =
the
> current code is to treat this scenario as an error, but unfortunate this
> doesn't work as expected, so let's fix this.
>
> The other part is to guarantee that a power cycle of the SDIO card has b=
een
> completed when wl12xx_sdio_power_on() returns, as to allow the FW
> programming to succeed. However, relying solely on runtime PM to deal wi=
th
> this isn't sufficient. For example, userspace may prevent runtime suspen=
d
> via sysfs for the device that represents the SDIO card, leading to that =
the
> mmc core also keeps it powered on. For this reason, let's instead do a
> brute force power cycle in wl12xx_sdio_power_on().
>
> Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling"=
)
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>
> Changes in v2:
> 	- Keep the SDIO host claimed when calling mmc_hw_reset().
> 	- Add a fixes tag.
> ---
>   drivers/net/wireless/ti/wlcore/sdio.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireles=
s/ti/wlcore/sdio.c
> index bd10165d7eec..4d4b07701149 100644
> --- a/drivers/net/wireless/ti/wlcore/sdio.c
> +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> @@ -164,6 +164,12 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_=
glue *glue)
>   	}
>
>   	sdio_claim_host(func);
> +	/*
> +	 * To guarantee that the SDIO card is power cycled, as required to mak=
e
> +	 * the FW programming to succeed, let's do a brute force HW reset.
> +	 */
> +	mmc_hw_reset(card->host);
> +
>   	sdio_enable_func(func);
>   	sdio_release_host(func);
>
> @@ -174,20 +180,13 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdi=
o_glue *glue)
>   {
>   	struct sdio_func *func =3D dev_to_sdio_func(glue->dev);
>   	struct mmc_card *card =3D func->card;
> -	int error;
>
>   	sdio_claim_host(func);
>   	sdio_disable_func(func);
>   	sdio_release_host(func);
>
>   	/* Let runtime PM know the card is powered off */
> -	error =3D pm_runtime_put(&card->dev);
> -	if (error < 0 && error !=3D -EBUSY) {
> -		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
> -
> -		return error;
> -	}
> -
> +	pm_runtime_put(&card->dev);
>   	return 0;
>   }
>
>

Just tested on both HiKey (620) and Ultra96 but it fails to fix the issue =
on
both. I'm getting

wl1271_sdio: probe of mmc2:0001:1 failed with error -16

during boot again, and the interface is not available.

Jan
