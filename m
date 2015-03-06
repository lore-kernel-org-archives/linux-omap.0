From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 13/15] twl4030_charger: add ac/mode to match usb/mode
Date: Fri, 6 Mar 2015 23:59:04 +0200
Message-ID: <CANOLnOOJhz3JSevuz7T+XZDquEvJ-UiVM4KVHxxa4mSqb-yTpg@mail.gmail.com>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043352.4243.8071.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224043352.4243.8071.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 24, 2015 at 6:33 AM, NeilBrown <neilb@suse.de> wrote:
> This allows AC charging to be turned off, much like usb charging.
>
> "continuous" (aka "linear") mode maps to the CVENAC (constant voltage=
)
> feature of the twl4030.

Are you sure? Before your patches CVENAC was set at all times and and
charger still worked in automatic mode.

>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/power/twl4030_charger.c |   40 +++++++++++++++++++++++++++++=
----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_=
charger.c
> index 6c53f0b601a4..e5a0225ea87e 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -112,7 +112,7 @@ struct twl4030_bci {
>         int                     ichg_eoc, ichg_lo, ichg_hi;
>         int                     usb_cur, ac_cur;
>         bool                    ac_is_active;
> -       int                     usb_mode; /* charging mode requested =
*/
> +       int                     usb_mode, ac_mode; /* charging mode r=
equested */
>  #define        CHARGE_OFF      0
>  #define        CHARGE_AUTO     1
>  #define        CHARGE_LINEAR   2
> @@ -449,12 +449,18 @@ static int twl4030_charger_enable_usb(struct tw=
l4030_bci *bci, bool enable)
>  /*
>   * Enable/Disable AC Charge funtionality.
>   */
> -static int twl4030_charger_enable_ac(bool enable)
> +static int twl4030_charger_enable_ac(struct twl4030_bci *bci, bool e=
nable)
>  {
>         int ret;
>
> -       if (enable)
> -               ret =3D twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTO=
AC);
> +       if (bci->ac_mode =3D=3D CHARGE_OFF)
> +               enable =3D false;
> +
> +       if (enable && bci->ac_mode =3D=3D CHARGE_LINEAR)
> +               ret =3D twl4030_clear_set_boot_bci(0, (TWL4030_CVENAC=
 |
> +                                                    TWL4030_BCIAUTOA=
C));
> +       else if (enable)
> +               ret =3D twl4030_clear_set_boot_bci(TWL4030_CVENAC, TW=
L4030_BCIAUTOAC);
>         else
>                 ret =3D twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC,=
 0);

CVENAC is required to be set for operation on AC without battery
(which works fine on most pandora boards). After this patch, when
booted without battery,  the board will reset before there is a chance
to set the linear mode by userspace, because this is called on
probe...


Gra=C5=BEvydas
