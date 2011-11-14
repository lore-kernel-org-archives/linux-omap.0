From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Mon, 14 Nov 2011 09:23:12 -0800
Message-ID: <20111114172312.GI31337@atomide.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
 <1321274409-24643-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60368 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719Ab1KNRXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Nov 2011 12:23:17 -0500
Content-Disposition: inline
In-Reply-To: <1321274409-24643-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linus.walleij@stericsson.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

* Rajendra Nayak <rnayak@ti.com> [111114 04:05]:
> --- /dev/null
> +++ b/drivers/pinctrl/pinmux-omap.c
> @@ -0,0 +1,735 @@
> +
> +/* omap4 core pads */
> +static const struct pinctrl_pin_desc omap4_core_pads[] = {
> +	PINCTRL_PIN(0, "c12"),
> +	PINCTRL_PIN(1, "d12"),
> +	PINCTRL_PIN(2, "c13"),
...

Let's not even plan on adding this data here. We already have
about 6000 lines of pinmux data for omaps even without this patch.

Instead, just write something as a separate patch that populates
omap pinmux data from the existing data until we have the data
coming from DT.

> +/* omap4 wkup pads */
> +static const struct pinctrl_pin_desc omap4_wkup_pads[] = {
> +	PINCTRL_PIN(0, "c12"),
> +	PINCTRL_PIN(1, "d12"),
> +	PINCTRL_PIN(2, "c13"),
...

This too needs to go.

> +static const unsigned hdmi_pins[] = {
> +	44, /* HDMI_HPD */
> +	45, /* HDMI_CEC */
> +	46, /* HDMI_DDC_SCL */
> +	47, /* HDMI_DDC_SDA */
> +};
> +
> +static const unsigned hdmi_muxmodes[] = {
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +};
> +
> +static const unsigned sdmmc5_pins[] = {
> +	132, /* WLAN SDIO: MMC5 CMD */
> +	133, /* WLAN SDIO: MMC5 CLK */
> +	134, /* WLAN SDIO: MMC5 DAT0 */
> +	135, /* WLAN SDIO: MMC5 DAT1 */
> +	136, /* WLAN SDIO: MMC5 DAT2 */
> +	137, /* WLAN SDIO: MMC5 DAT3 */
> +};
> +
> +static const unsigned sdmmc5_muxmodes[] = {
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +	OMAP_MUX_MODE0,
> +};
> +
> +static const unsigned dispc2_pins[] = {
> +	145, /* dispc2_data23 */
> +	146, /* dispc2_data22 */
> +	147, /* dispc2_data21 */
...

And all of the above.. The same goes for all the static package
specific data.

> +/* handle 8 bit registers too, for now only worry about 16bit ones*/
> +static u16 omap_pmx_read(struct omap_pmx *opmx, unsigned pin)
> +{
> +	return __raw_readw(opmx->virtbase + (pin * 2));
> +}
> +
> +static void omap_pmx_write(u16 val, struct omap_pmx *opmx, unsigned pin)
> +{
> +	__raw_writew(val, opmx->virtbase + (pin * 2));
> +}

Might as well fix this one since we already have it working.

The rest looks OK to me as a minimal driver. I don't know if
we should still populate it with platform_data though, that
seems already broken as it's omap4 only. Might as well go with
the DT support to start with.

Regards,

Tony
