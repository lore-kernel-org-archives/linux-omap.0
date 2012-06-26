From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] pinctrl: Add one-register-per-pin type device tree based
 pinctrl driver
Date: Tue, 26 Jun 2012 11:05:48 -0600
Message-ID: <4FE9EBEC.9040208@wwwdotorg.org>
References: <20120611135826.GB12766@atomide.com> <4FDA6FCD.1020605@wwwdotorg.org> <20120615094938.GQ12766@atomide.com> <4FDB6000.5080703@wwwdotorg.org> <20120618055036.GU12766@atomide.com> <20120619135600.GX12766@atomide.com> <4FE39C86.5070901@wwwdotorg.org> <20120622083955.GZ12766@atomide.com> <4FE4AC40.8080400@wwwdotorg.org> <20120626134319.GA3483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120626134319.GA3483@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On 06/26/2012 07:43 AM, Tony Lindgren wrote:
...
> Subject: [PATCH] pinctrl: Add one-register-per-pin type device tree based pinctrl driver
> 
> Add one-register-per-pin type device tree based pinctrl driver.
> 
> This driver has been tested on omap2+ series of processors,
> where there is either an 8 or 16-bit padconf register for each pin.
> Support for other similar pinmux controllers can be added.

> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

> +/* board specific .dts file */
> +
> +&pmx_core {

> +	board_pins: pinmux_board_pins {
> +		pinctrl-single,pins = <
> +			0x6c 0xf	/* csi21_dx3 OUTPUT | MODE7 */
> +			0x6e 0xf	/* csi21_dy3 OUTPUT | MODE7 */
> +			0x70 0xf	/* csi21_dx4 OUTPUT | MODE7 */
> +			0x72 0xf	/* csi21_dy4 OUTPUT | MODE7 */

If you're removing the pinconf mask, I think the comments in the example
should reflect just setting a particular mux function, and remove any
references to pinconf settings in that field. While the binding can be
abused to do that, I think the docs shouldn't encourage it:-)

Other than that, the binding looks reasonable to me, given what it's
intended to do.

However, I'd still like Grant and Rob (and any other DT experts) to
explicitly sign off on this binding, because it's doing exactly
something that was rejected at Linaro Connect in February (albeit the
binding is slightly more oriented at specifically being for pinmux
rather than a fully general "blast in these register values", but that
distinction seems minor to me).
