From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/5] Input: Add tps65217 power button driver
Date: Thu, 7 Apr 2016 12:57:32 -0500
Message-ID: <20160407175732.GH32257@rob-hp-laptop>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
 <1459789865-3704-7-git-send-email-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459789865-3704-7-git-send-email-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 04, 2016 at 07:11:05PM +0200, Marcin Niestroj wrote:
> This driver enables us to use tps65217's power button as KEY_POWER on
> am335x boards (directly connected button in chiliboard, accessible pin
> via expansion header in beaglebone). This patch has been tested with
> chiliboard.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
>  .../bindings/input/tps65217-pwrbutton.txt          |  14 +++
>  drivers/input/misc/Kconfig                         |  10 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/tps65217-pwrbutton.c            | 131 +++++++++++++++++++++
>  4 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
>  create mode 100644 drivers/input/misc/tps65217-pwrbutton.c
> 
> diff --git a/Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
> new file mode 100644
> index 0000000..6cba51d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
> @@ -0,0 +1,14 @@
> +Texas Instruments TPS65217 power button
> +
> +This driver provides a simple power button event via an Interrupt.

Please specify what exactly this is a sub-node of.

> +
> +Required properties:
> +- compatible: should be "ti,tps65217-pwrbutton"
> +
> +Example:
> +
> +&tps {
> +	tps65217-pwrbutton {
> +		compatible = "ti,tps65217-pwrbutton";
> +	};
> +};
