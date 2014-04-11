From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 07/11] ARM: dts: Enable N900 keybaord sleep leds by
 default
Date: Sat, 12 Apr 2014 02:31:09 +0300
Message-ID: <20140411233109.GG15736@drone.musicnaut.iki.fi>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:57820 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbaDKXf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 19:35:27 -0400
Content-Disposition: inline
In-Reply-To: <1397173639-29587-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Paul Walmsley <paul@pwsan.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>

Hi,

On Thu, Apr 10, 2014 at 04:47:15PM -0700, Tony Lindgren wrote:
> +        leds {
> +                compatible = "gpio-leds";
> +                heartbeat {
> +                        label = "debug::sleep";
> +                        gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
> +                        linux,default-trigger = "default-on";

Just some very minor nits, spaces should be converted to TABs here
for indent, and patch title should say "keyboard" instead of "keybaord".

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&debug_leds>;
> +                };
> +        };

A.
