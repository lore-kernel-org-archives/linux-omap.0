From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] ARM:dts:omap4-panda:Update the LED support for the
 panda DTS
Date: Wed, 8 May 2013 16:47:46 -0700
Message-ID: <20130508234745.GV32546@atomide.com>
References: <1366229760-4808-1-git-send-email-dmurphy@ti.com>
 <516FBD18.3060501@ti.com>
 <51703BEF.6050804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51703BEF.6050804@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Vincent =?utf-8?Q?Stehl=C3=A9?= <v-stehle@ti.com>, b-cousson@ti.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [130418 11:35]:
> On 04/18/2013 04:30 AM, Vincent Stehl=C3=A9 wrote:
> >On 04/17/2013 10:16 PM, Dan Murphy wrote:
> >>The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-pand=
a-es
> >>are different.
> >(..)
> >>diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/b=
oot/dts/omap4-panda-common.dtsi
> >>index 03bd60d..0c48f6b 100644
> >>--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> >>+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> >(..)
> >>@@ -135,6 +136,25 @@
> >>  			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
> >>  		>;
> >>  	};
> >>+
> >>+	led_gpio_pins: pinmux_leds_pins {
> >>+		pinctrl-single,pins =3D <
> >>+		>;
> >>+	};
> >>+};
> >Hi,
> >
> >FYI, there was a recent discussion precisely on this topic, where To=
my
> >suggested to remove the empty section:
> >http://marc.info/?l=3Dlinux-omap&m=3D136546635409232&w=3D2
> >
> >Apart from that, I just tested your patch on top of Tomy's
> >omap-for-v3.10/dt branch and it is working fine for me on PandaBoard=
s
> >EA3, A4 and ES.
> >
> >Tested-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
> >
> >Best regards,
> >
> >V.
> >
> Thanks for testing Vincent
>=20
> Is there a way to append the data to an already existing node?
> I do not see a clean way.

If you have something in omap4-panda-common.dtsi and the same entry
in the omap4-panda-es.dts, the entries in omap4-panda-es.dts will
override and append the entries in omap4-panda-common.dtsi.

So I think you can avoid the empty entry that way.

Regards,

Tony
