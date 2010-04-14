From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [RFC] [PATCH 2/3] OMAP4: Keyboard Board Support
Date: Wed, 14 Apr 2010 10:49:21 +0530
Message-ID: <s2xce9ab5791004132219q528e6c7cyb709d78f8dc177ee@mail.gmail.com>
References: <Acrbb1c3f6VIFUq3RumCrtM3k0PWuQ==> <27F9C60D11D683428E133F85D2BB4A53043D9EE7F6@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F6@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 14, 2010 at 6:40 AM, Arce, Abraham <x0066660@ti.com> wrote:
> From: Syed Rafiuddin <rafiuddin.syed@ti.com>
>
> Keyboard support for SDP OMAP4430
>
> Signed-off-by: Abraham Arce <x0066660@ti.com>
> ---

'Form: Syed Rafiuddin', but not 'Signed-off-by:'... is it correct?


> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 61 ++++++++++++++-------=
-------------
> =A01 files changed, 25 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index 9a35367..747a4d8 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -35,16 +35,13 @@
> =A0#include <plat/timer-gp.h>
> =A0#include <plat/usb.h>
> =A0#include <plat/syntm12xx.h>
> -#include <plat/keypad.h>
> =A0#include <asm/hardware/gic.h>
> =A0#include <asm/hardware/cache-l2x0.h>
> =A0#include <linux/i2c/twl.h>
> =A0#include <linux/regulator/machine.h>
> =A0#include "mmc-twl4030.h"
>
> -#define OMAP4_KBDOCP_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x4A31C000
> -
> -static int omap_keymap[] =3D {
> +static int sdp4430_keymap[] =3D {
> =A0 =A0 =A0 =A0KEY(0, 0, KEY_E),
> =A0 =A0 =A0 =A0KEY(0, 1, KEY_D),
> =A0 =A0 =A0 =A0KEY(0, 2, KEY_X),
> @@ -52,7 +49,7 @@ static int omap_keymap[] =3D {
> =A0 =A0 =A0 =A0KEY(0, 4, KEY_W),
> =A0 =A0 =A0 =A0KEY(0, 5, KEY_S),
> =A0 =A0 =A0 =A0KEY(0, 6, KEY_Q),
> - =A0 =A0 =A0 KEY(0, 7, KEY_UNKNOWN),
> + =A0 =A0 =A0 KEY(0, 7, KEY_PROG1),
>
> =A0 =A0 =A0 =A0KEY(1, 0, KEY_R),
> =A0 =A0 =A0 =A0KEY(1, 1, KEY_F),
> @@ -61,7 +58,7 @@ static int omap_keymap[] =3D {
> =A0 =A0 =A0 =A0KEY(1, 4, KEY_Y),
> =A0 =A0 =A0 =A0KEY(1, 5, KEY_H),
> =A0 =A0 =A0 =A0KEY(1, 6, KEY_A),
> - =A0 =A0 =A0 KEY(1, 7, KEY_UNKNOWN),
> + =A0 =A0 =A0 KEY(1, 7, KEY_PROG2),
>
> =A0 =A0 =A0 =A0KEY(2, 0, KEY_T),
> =A0 =A0 =A0 =A0KEY(2, 1, KEY_G),
> @@ -70,23 +67,23 @@ static int omap_keymap[] =3D {
> =A0 =A0 =A0 =A0KEY(2, 4, KEY_U),
> =A0 =A0 =A0 =A0KEY(2, 5, KEY_J),
> =A0 =A0 =A0 =A0KEY(2, 6, KEY_N),
> - =A0 =A0 =A0 KEY(2, 7, KEY_UNKNOWN),
> + =A0 =A0 =A0 KEY(2, 7, KEY_PROG3),
>
> =A0 =A0 =A0 =A0KEY(3, 0, KEY_HOME),
> =A0 =A0 =A0 =A0KEY(3, 1, KEY_SEND),
> =A0 =A0 =A0 =A0KEY(3, 2, KEY_END),
> =A0 =A0 =A0 =A0KEY(3, 3, KEY_F1),
> - =A0 =A0 =A0 KEY(3, 4, KEY_LEFTSHIFT),
> + =A0 =A0 =A0 KEY(3, 4, KEY_F2),
> =A0 =A0 =A0 =A0KEY(3, 5, KEY_F3),
> =A0 =A0 =A0 =A0KEY(3, 6, KEY_BACK),
> - =A0 =A0 =A0 KEY(3, 7, KEY_UNKNOWN),
> + =A0 =A0 =A0 KEY(3, 7, KEY_PROG4),
>
> - =A0 =A0 =A0 KEY(4, 0, KEY_UNKNOWN),
> - =A0 =A0 =A0 KEY(4, 1, KEY_UNKNOWN),
> - =A0 =A0 =A0 KEY(4, 2, KEY_UNKNOWN),
> - =A0 =A0 =A0 KEY(4, 3, KEY_UNKNOWN),
> + =A0 =A0 =A0 KEY(4, 0, KEY_F5),
> + =A0 =A0 =A0 KEY(4, 1, KEY_F6),
> + =A0 =A0 =A0 KEY(4, 2, KEY_F7),
> + =A0 =A0 =A0 KEY(4, 3, KEY_F8),
> =A0 =A0 =A0 =A0KEY(4, 4, KEY_VOLUMEUP),
> - =A0 =A0 =A0 KEY(4, 5, KEY_UNKNOWN),
> + =A0 =A0 =A0 KEY(4, 5, KEY_F9),
> =A0 =A0 =A0 =A0KEY(4, 6, KEY_BACKSPACE),
> =A0 =A0 =A0 =A0KEY(4, 7, KEY_F4),
>
> @@ -108,7 +105,7 @@ static int omap_keymap[] =3D {
> =A0 =A0 =A0 =A0KEY(6, 6, KEY_P),
> =A0 =A0 =A0 =A0KEY(6, 7, KEY_OK),
>
> - =A0 =A0 =A0 KEY(7, 0, KEY_UNKNOWN),
> + =A0 =A0 =A0 KEY(7, 0, KEY_LEFTSHIFT),
> =A0 =A0 =A0 =A0KEY(7, 1, KEY_ENTER),
> =A0 =A0 =A0 =A0KEY(7, 2, KEY_CAPSLOCK),
> =A0 =A0 =A0 =A0KEY(7, 3, KEY_SPACE),
> @@ -119,31 +116,23 @@ static int omap_keymap[] =3D {
> =A0 =A0 =A0 =A00,
> =A0};

Are you aware of that interpretation of 'row' and 'col' get reversed
in matrix keymap framework.
Also last element '0' should be removed.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
