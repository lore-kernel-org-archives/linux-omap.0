From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: dts: AM33XX: Use pinctrl constants
Date: Sun, 2 Jun 2013 12:43:23 -0500
Message-ID: <CAD=GYpbYZwhSdTjSbskT2DxKjV5OJmAa4zZ5=MA4Kw0Zn3edBQ@mail.gmail.com>
References: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
 <1370004142-30506-5-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8086943310113915085=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370004142-30506-5-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--===============8086943310113915085==
Content-Type: multipart/alternative; boundary=047d7b5d2c00723bf204de2f62de

--047d7b5d2c00723bf204de2f62de
Content-Type: text/plain; charset=ISO-8859-1

Hi Florian,

This is very cool.. :-)

On Fri, May 31, 2013 at 7:42 AM, Florian Vaussard
<florian.vaussard-p8DiymsW2f8@public.gmane.org>wrote:

> Using constants for pinctrl allows a better readability, and removes
> redundancy with comments.
>
> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bone.dts  |   18 +++++++++---------
>  arch/arm/boot/dts/am335x-evm.dts   |   28 ++++++++++++++--------------
>  arch/arm/boot/dts/am335x-evmsk.dts |   26 +++++++++++++-------------
>  arch/arm/boot/dts/am33xx.dtsi      |    1 +
>  4 files changed, 37 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone.dts
> b/arch/arm/boot/dts/am335x-bone.dts
> index 5bfb7dd..61d0793 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -30,30 +30,30 @@
>
>                 user_leds_s0: user_leds_s0 {
>                         pinctrl-single,pins = <
> -                               0x54 0x7        /* gpmc_a5.gpio1_21,
> OUTPUT | MODE7 */
> -                               0x58 0x17       /* gpmc_a6.gpio1_22,
> OUTPUT_PULLUP | MODE7 */
> -                               0x5c 0x7        /* gpmc_a7.gpio1_23,
> OUTPUT | MODE7 */
> -                               0x60 0x17       /* gpmc_a8.gpio1_24,
> OUTPUT_PULLUP | MODE7 */
> +                               0x54 (PIN_OUTPUT | MUX_MODE7)           /*
> gpmc_a5.gpio1_21 */
> +                               0x58 (PIN_OUTPUT | PULL_UP | MUX_MODE7) /*
> gpmc_a6.gpio1_22 */
> +                               0x5c (PIN_OUTPUT | MUX_MODE7)           /*
> gpmc_a7.gpio1_23 */
> +                               0x60 (PIN_OUTPUT | PULL_UP | MUX_MODE7) /*
> gpmc_a8.gpio1_24 */
>
>
Does it make sense to also replace the pinmux offets with constants?
Removal of the comment would mean looking at the DTS one still has to go
back to the TRM to figure out what is the name for a particular offset.

Thanks,
Joel

--047d7b5d2c00723bf204de2f62de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Florian,<div><br></div><div>This is very cool.. :-)<br>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, May 31, 2=
013 at 7:42 AM, Florian Vaussard <span dir=3D"ltr">&lt;<a href=3D"mailto:fl=
orian.vaussard-p8DiymsW2f8@public.gmane.org" target=3D"_blank">florian.vaussard-p8DiymsW2f8@public.gmane.org</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Using constants for pinctrl allows a better readability, a=
nd removes<br>

redundancy with comments.<br>
<br>
Signed-off-by: Florian Vaussard &lt;<a href=3D"mailto:florian.vaussard@epfl=
.ch">florian.vaussard-p8DiymsW2f8@public.gmane.org</a>&gt;<br>
---<br>
=A0arch/arm/boot/dts/am335x-bone.dts =A0| =A0 18 +++++++++---------<br>
=A0arch/arm/boot/dts/am335x-evm.dts =A0 | =A0 28 ++++++++++++++------------=
--<br>
=A0arch/arm/boot/dts/am335x-evmsk.dts | =A0 26 +++++++++++++-------------<b=
r>
=A0arch/arm/boot/dts/am33xx.dtsi =A0 =A0 =A0| =A0 =A01 +<br>
=A04 files changed, 37 insertions(+), 36 deletions(-)<br>
<br>
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-b=
one.dts<br>
index 5bfb7dd..61d0793 100644<br>
--- a/arch/arm/boot/dts/am335x-bone.dts<br>
+++ b/arch/arm/boot/dts/am335x-bone.dts<br>
@@ -30,30 +30,30 @@<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user_leds_s0: user_leds_s0 {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinctrl-single,pins =3D &lt=
;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x54 0x7 =A0 =
=A0 =A0 =A0/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x58 0x17 =A0=
 =A0 =A0 /* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x5c 0x7 =A0 =
=A0 =A0 =A0/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x60 0x17 =A0=
 =A0 =A0 /* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x54 (PIN_OUT=
PUT | MUX_MODE7) =A0 =A0 =A0 =A0 =A0 /* gpmc_a5.gpio1_21 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x58 (PIN_OUT=
PUT | PULL_UP | MUX_MODE7) /* gpmc_a6.gpio1_22 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x5c (PIN_OUT=
PUT | MUX_MODE7) =A0 =A0 =A0 =A0 =A0 /* gpmc_a7.gpio1_23 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x60 (PIN_OUT=
PUT | PULL_UP | MUX_MODE7) /* gpmc_a8.gpio1_24 */<br><br></blockquote><div>=
<br></div><div style>Does it make sense to also replace the pinmux offets w=
ith constants?</div><div style>
Removal of the comment would mean looking at the DTS one still has to go ba=
ck to the TRM to figure out what is the name for a particular offset.</div>=
<div style><br></div><div style>Thanks,</div><div style>Joel</div></div>
</div></div></div>

--047d7b5d2c00723bf204de2f62de--

--===============8086943310113915085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8086943310113915085==--
