From: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <v-stehle@ti.com>
Subject: Re: [PATCHv2] ARM:dts:omap4-panda:Update the LED support for the
 panda DTS
Date: Thu, 18 Apr 2013 11:30:00 +0200
Message-ID: <516FBD18.3060501@ti.com>
References: <1366229760-4808-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1366229760-4808-1-git-send-email-dmurphy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/17/2013 10:16 PM, Dan Murphy wrote:
> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
> are different.
(..)
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dt=
s/omap4-panda-common.dtsi
> index 03bd60d..0c48f6b 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
(..)
> @@ -135,6 +136,25 @@
>  			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
>  		>;
>  	};
> +
> +	led_gpio_pins: pinmux_leds_pins {
> +		pinctrl-single,pins =3D <
> +		>;
> +	};
> +};

Hi,

FYI, there was a recent discussion precisely on this topic, where Tomy
suggested to remove the empty section:
http://marc.info/?l=3Dlinux-omap&m=3D136546635409232&w=3D2

Apart from that, I just tested your patch on top of Tomy's
omap-for-v3.10/dt branch and it is working fine for me on PandaBoards
EA3, A4 and ES.

Tested-by: Vincent Stehl=E9 <v-stehle@ti.com>

Best regards,

V.
