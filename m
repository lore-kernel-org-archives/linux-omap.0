From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH v3 1/2] REGULATOR: TWL6025: add support to twl-regulator
Date: Fri, 20 May 2011 20:19:21 +0530
Message-ID: <BANLkTi=jccSDyG9R2pESN9XCwnViLh5tpg@mail.gmail.com>
References: <1305743570-12074-1-git-send-email-gg@slimlogic.co.uk>
	<1305743570-12074-2-git-send-email-gg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305743570-12074-2-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, balbi@ti.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, linux@slimlogic.co.uk, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, May 19, 2011 at 12:02 AM, Graeme Gregory <gg@slimlogic.co.uk> w=
rote:
> Adding support for the twl6025. Major difference in the twl6025 is th=
e
> group functionality has been removed from the chip so this affects ho=
w
> regulators are enabled and disabled.
>
> The names of the regulators also changed.
>
> The DCDCs of the 6025 are software controllable as well.
>
> Since V1
>
> Use the features variable passed via platform data instead of calling
> global function.
>
> Change the very switch like if statements to be a more readable
> switch statement.
>
> Since V2
>
> twl6025 doesn't use remap so remove it from the macros.
>
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> ---
> =A0drivers/regulator/twl-regulator.c | =A0410 +++++++++++++++++++++++=
++++++++++---
> =A01 files changed, 375 insertions(+), 35 deletions(-)
>

<snip>

> +
> +static int twl6030dcdc_list_voltage(struct regulator_dev *rdev, unsi=
gned index)
> +{
> +       struct twlreg_info      *info =3D rdev_get_drvdata(rdev);
> +
> +       int voltage =3D 0;
> +
> +       switch (info->flags) {
> +       case 0:
> +               switch (index) {
> +               case 0:
> +                       voltage =3D 0;
> +                       break;
> +               case 58:

Not sure if hex 0x3A is better here, TRM gives in binary though.

> +                       voltage =3D 1350 * 1000;
> +                       break;
> +               case 59:
> +                       voltage =3D 1500 * 1000;
> +                       break;
> +               case 60:
> +                       voltage =3D 1800 * 1000;
> +                       break;
> +               case 61:
> +                       voltage =3D 1900 * 1000;
> +                       break;
> +               case 62:
> +                       voltage =3D 2100 * 1000;
> +                       break;
> +               default:
> +                       voltage =3D (600000 + (12500 * (index - 1)));
> +               }
> +               break;
> +       case DCDC_OFFSET_EN:
> +               switch (index) {
> +               case 0:
> +                       voltage =3D 0;
> +                       break;
> +               case 58:
> +                       voltage =3D 1350 * 1000;
> +                       break;
> +               case 59:
> +                       voltage =3D 1500 * 1000;
> +                       break;
> +               case 60:
> +                       voltage =3D 1800 * 1000;
> +                       break;
> +               case 61:
> +                       voltage =3D 1900 * 1000;
> +                       break;
> +               case 62:
> +                       voltage =3D 2100 * 1000;
> +                       break;
> +               default:
> +                       voltage =3D (700000 + (12500 * (index - 1)));

Between DCDC_OFFSET_EN and case 0
700000 and 600000 is the only difference,
can it be handled via additional 100000 in case DCDC_OFFSET_EN?
like
+	case DCDC_OFFSET_EN:
	voltage =3D 100000;
	/* fall through */
+	case 0:
	voltage +=3D (600000 + (12500 * (index - 1)));

> +               }
> +               break;
> +       case DCDC_EXTENDED_EN:
> +               switch (index) {
> +               case 0:
> +                       voltage =3D 0;
> +                       break;
> +               case 58:
> +                       voltage =3D 2084 * 1000;
> +                       break;
> +               case 59:
> +                       voltage =3D 2315 * 1000;
> +                       break;
> +               case 60:
> +                       voltage =3D 2778 * 1000;
> +                       break;
> +               case 61:
> +                       voltage =3D 2932 * 1000;
> +                       break;
> +               case 62:
> +                       voltage =3D 3241 * 1000;
> +                       break;
> +               default:
> +                       voltage =3D (1852000 + (38600 * (index - 1)))=
;
> +               }
> +               break;
> +       case DCDC_OFFSET_EN|DCDC_EXTENDED_EN:

space between |

> +               switch (index) {

> +
> +static int
> +twl6030dcdc_set_voltage(struct regulator_dev *rdev, int min_uV, int =
max_uV,
> +                       unsigned int *selector)
> +{
> +       struct twlreg_info      *info =3D rdev_get_drvdata(rdev);
> +       int     vsel =3D 0;
> +
> +       switch (info->flags) {
> +       case 0:
> +               if (min_uV =3D=3D 0)
> +                       vsel =3D 0;
> +               else if ((min_uV >=3D 600000) && (max_uV <=3D 1300000=
)) {
> +                       vsel =3D (min_uV - 600000) / 125;
> +                       if (vsel % 100)
> +                               vsel +=3D 100;
> +                       vsel /=3D 100;
> +                       vsel++;
> +               }
> +               /* Values 1..57 for vsel are linear and can be calcul=
ated
> +                * values 58..62 are non linear.
> +                */
> +               else if ((min_uV > 1900000) && (max_uV >=3D 2100000))
> +                       vsel =3D 62;
> +               else if ((min_uV > 1800000) && (max_uV >=3D 1900000))
> +                       vsel =3D 61;
> +               else if ((min_uV > 1500000) && (max_uV >=3D 1800000))
> +                       vsel =3D 60;
> +               else if ((min_uV > 1350000) && (max_uV >=3D 1500000))
> +                       vsel =3D 59;
> +               else if ((min_uV > 1300000) && (max_uV >=3D 1350000))
> +                       vsel =3D 58;
> +               else
> +                       return -EINVAL;
> +               break;
> +       case DCDC_OFFSET_EN:
> +               if (min_uV =3D=3D 0)
> +                       vsel =3D 0;
> +               else if ((min_uV >=3D 700000) && (max_uV <=3D 1420000=
)) {
> +                       vsel =3D (min_uV - 600000) / 125;

s/600000/700000 ?

> +                       if (vsel % 100)
> +                               vsel +=3D 100;
> +                       vsel /=3D 100;
> +                       vsel++;
> +               }

> +static struct regulator_ops twldcdc_ops =3D {
> +       .list_voltage           =3D twl6030dcdc_list_voltage,
> +
> +       .set_voltage            =3D twl6030dcdc_set_voltage,
> +       .get_voltage_sel        =3D twl6030dcdc_get_voltage_sel,

In 6030 TRM, dcdc is mentioned as SMPS
Is it different it in 6025 TRM?
