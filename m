From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] memory: omap-gpmc: Fix unselectable debug option for GPMC
Date: Tue, 6 Oct 2015 15:18:05 +0300
Message-ID: <5613BBFD.60401@ti.com>
References: <1444133636-31430-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444133636-31430-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/10/15 15:13, Tony Lindgren wrote:
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug=
")
> added a debug option for GPMC, but somehow managed to keep it unselec=
table.
>=20
> This probably happened because I had some uncommitted changes and the
> GPMC option is selected in the platform specific Kconfig.
>=20
> Let's also update the description a bit, it does not mention that
> enabling the debug option also disables the reset of GPMC controller
> during the init as pointed out by Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de>.
>=20
> Fixes: 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug=
")
> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  drivers/memory/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -58,12 +58,13 @@ config OMAP_GPMC
>  	  memory drives like NOR, NAND, OneNAND, SRAM.
> =20
>  config OMAP_GPMC_DEBUG
> -	bool
> +	bool "Enable GPMC debug output and skip reset of GPMC during init"
>  	depends on OMAP_GPMC
>  	help
>  	  Enables verbose debugging mostly to decode the bootloader provide=
d
> -	  timings. Enable this during development to configure devices
> -	  connected to the GPMC bus.
> +	  timings. To preserve the bootloader provided timings, the reset
> +	  of GPMC is skipped during init. Enable this during development to
> +	  configure devices connected to the GPMC bus.
> =20
>  config MVEBU_DEVBUS
>  	bool "Marvell EBU Device Bus Controller"
>=20

--
cheers,
-roger
