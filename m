From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] omap: beagle: add support for wl1271 on the board file
Date: Thu, 23 Sep 2010 13:30:21 +0300
Message-ID: <AANLkTinLjQbvbTj3LTnw+54S-ojWzojqgyd=-3F783We@mail.gmail.com>
References: <1285230003-5065-1-git-send-email-luciano.coelho@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285230003-5065-1-git-send-email-luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 23, 2010 at 11:20 AM, Luciano Coelho
<luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> Add board configuration for the wl1271 daughter board. =A0This patch =
is based
> on Ohad Ben-Cohen's patches for Zoom boards.

Hm can that daughter board be detected? With your patch all beagle
users will get GPIO139 toggled, and if someone has that wired to
chainsaw switch somebody might get hurt.

> Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
> There was a useless variable defined in omap3_beagle_init() that was =
causing a
> warning. =A0I have removed it in v2.
>
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 69 +++++++++++++++++=
++++++++++++++
> =A0drivers/net/wireless/wl12xx/wl1271.h =A0 =A0| =A0 =A02 +-
> =A02 files changed, 70 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 87969c7..755df29 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c

<snip>

> +static struct regulator_consumer_supply beagle_vmmc2_supply =3D {
> + =A0 =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vmmc",
> + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D "mmci-omap-hs.1",
> +};
> +
> +

single newline is enough.

> =A0static struct regulator_consumer_supply beagle_vsim_supply =3D {
> =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc_aux"=
,
> =A0};
>
> +

here too.

> +static struct regulator_init_data beagle_vmmc2 =3D {
> + =A0 =A0 =A0 .constraints =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_ST=
ATUS,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_consumer_supplies =3D 1,
> + =A0 =A0 =A0 .consumer_supplies =3D &beagle_vmmc2_supply,
> +};
> +
> +static struct fixed_voltage_config beagle_vwlan =3D {
> + =A0 =A0 =A0 .supply_name =3D "vwl1271",
> + =A0 =A0 =A0 .microvolts =3D 1800000, =A0/* 1.8V */
> + =A0 =A0 =A0 .gpio =3D OMAP_BEAGLE_WLAN_EN_GPIO,
> + =A0 =A0 =A0 .startup_delay =3D 70000, /* 70ms */
> + =A0 =A0 =A0 .enable_high =3D 1,
> + =A0 =A0 =A0 .enabled_at_boot =3D 0,
> + =A0 =A0 =A0 .init_data =3D &beagle_vmmc2,
> +};

We tabify all structures in board files, take a look at other structure=
s.

<snip>

> diff --git a/drivers/net/wireless/wl12xx/wl1271.h b/drivers/net/wirel=
ess/wl12xx/wl1271.h
> index 4134f44..8bb028e 100644
> --- a/drivers/net/wireless/wl12xx/wl1271.h
> +++ b/drivers/net/wireless/wl12xx/wl1271.h
> @@ -60,7 +60,7 @@ enum {
> =A0 =A0 =A0 =A0DEBUG_ALL =A0 =A0 =A0 =3D ~0,
> =A0};
>
> -#define DEBUG_LEVEL (DEBUG_NONE)
> +#define DEBUG_LEVEL (DEBUG_MAC80211 | DEBUG_CMD | DEBUG_ACX | DEBUG_=
BOOT)

I guess you didn't want that?
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
