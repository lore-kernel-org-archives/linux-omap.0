From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 20 May 2014 07:39:32 -0700
Message-ID: <20140520143932.GA27830@atomide.com>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13684 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753518AbaETOjk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 10:39:40 -0400
Content-Disposition: inline
In-Reply-To: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140520 07:26]:
> @@ -77,6 +94,15 @@
>  			0x30 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
>  		>;
>  	};
> +
> +	dss_hdmi_pins: pinmux_dss_hdmi_pins {
> +		pinctrl-single,pins = <
> +			0x58 (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_hpd.hdmi_hpd */
> +			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
> +			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
> +			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
> +		>;
> +	};
>  };
>  
>  &i2c2 {

This seems to apply with fuzz against omap-for-v3.16/dt-v2, but
should be updated against omap-for-v3.16/dt-v2 to use OMAP4_IOPAD
as omap4-duovero-parlor.dts is now using it. That makes checking
the muxing easier against the TRM. See commit 5efa994b0d49 for
the script Joachim used.

Regards,

Tony
