From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Revert "ARM: RX-51: Enable isp1704 power on/off"
Date: Mon, 5 Dec 2011 19:31:52 +0200
Message-ID: <CAMP44s3Szzm9iXxghXfNCBjKyUw-nRrG1aEeweKnRCidaxmxEA@mail.gmail.com>
References: <1323105820-25946-1-git-send-email-felipe.contreras@nokia.com>
	<1323105820-25946-3-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323105820-25946-3-git-send-email-felipe.contreras@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-main <linux-kernel@vger.kernel.org>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Heikki Krogerus <heikki.krogerus@nokia.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Should probably have CC'ed linux-omap.

On Mon, Dec 5, 2011 at 7:23 PM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> This reverts commit 10299e2e4e3ed3b16503d4e04edd48b33083f4e2.
>
> This seems to break USB networking stuff.
>
> Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> Cc: Heikki Krogerus <heikki.krogerus@nokia.com>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-rx51-peripherals.c | =C2=A0 27 +-----=
-------------------
> =C2=A01 files changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/=
mach-omap2/board-rx51-peripherals.c
> index ba1aa07..9f8e4d2 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -23,7 +23,6 @@
> =C2=A0#include <linux/gpio.h>
> =C2=A0#include <linux/gpio_keys.h>
> =C2=A0#include <linux/mmc/host.h>
> -#include <linux/power/isp1704_charger.h>
>
> =C2=A0#include <plat/mcspi.h>
> =C2=A0#include <plat/board.h>
> @@ -56,8 +55,6 @@
> =C2=A0#define RX51_FMTX_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A053
> =C2=A0#define RX51_LP5523_CHIP_EN_GPIO =C2=A0 =C2=A0 =C2=A0 41
>
> -#define RX51_USB_TRANSCEIVER_RST_GPIO =C2=A067
> -
> =C2=A0/* list all spi devices here */
> =C2=A0enum {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0RX51_SPI_WL1251,
> @@ -174,30 +171,10 @@ static struct spi_board_info rx51_peripherals_s=
pi_board_info[] __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> -static void rx51_charger_set_power(bool on)
> -{
> - =C2=A0 =C2=A0 =C2=A0 gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, =
on);
> -}
> -
> -static struct isp1704_charger_data rx51_charger_data =3D {
> - =C2=A0 =C2=A0 =C2=A0 .set_power =C2=A0 =C2=A0 =C2=A0=3D rx51_charge=
r_set_power,
> -};
> -
> =C2=A0static struct platform_device rx51_charger_device =3D {
> - =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "isp1704_charger",
> - =C2=A0 =C2=A0 =C2=A0 .dev =C2=A0 =C2=A0=3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =3D=
 &rx51_charger_data,
> - =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .name =3D "isp1704_charger",
> =C2=A0};
>
> -static void __init rx51_charger_init(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_=
RST_GPIO,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPIOF_OUT_INIT_LOW=
, "isp1704_reset"));
> -
> - =C2=A0 =C2=A0 =C2=A0 platform_device_register(&rx51_charger_device)=
;
> -}
> -
> =C2=A0#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GP=
IO_MODULE)
>
> =C2=A0#define RX51_GPIO_CAMERA_LENS_COVER =C2=A0 =C2=A0110
> @@ -1102,6 +1079,6 @@ void __init rx51_peripherals_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (partition)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_hsmmc_in=
it(mmc);
>
> - =C2=A0 =C2=A0 =C2=A0 rx51_charger_init();
> + =C2=A0 =C2=A0 =C2=A0 platform_device_register(&rx51_charger_device)=
;
> =C2=A0}

--=20
=46elipe Contreras
