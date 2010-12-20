From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v2] Keyboard: omap-keypad: use matrix_keypad.h
Date: Mon, 20 Dec 2010 17:29:32 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1012201720470.13087@esdhcp041196.research.nokia.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl> <20101218060104.GA1623@core.coreip.homeip.net> <201012181639.29820.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:23546 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab0LTPay (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 10:30:54 -0500
In-Reply-To: <201012181639.29820.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

Hello,

On Sat, 18 Dec 2010, Janusz Krzysztofik wrote:
> Most keypad drivers make use of the <linux/input/matrix_keypad.h>
> defined macros, structures and inline functions.
>
> Convert omap-keypad driver to use those as well, as suggested by a
> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
>
> Created against linux-2.6.37-rc5.
> Tested on Amstrad Delta.
> Compile tested with omap1_defconfig and omap2plus_defconfig shrinked to
> board-h4.
>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

[...]

> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig 2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c      2010-12-18 16:23:29.000000000 +0100
> @@ -46,81 +46,79 @@ static u16 ams_delta_latch2_reg;
> static int ams_delta_keymap[] = {

[...]

> +static const struct matrix_keymap_data ams_delta_keymap_data = {
> +       .keymap         = ams_delta_keymap,
> +       .keymap_size    = ARRAY_SIZE(ams_delta_keymap),
> +};

You should update the ams_delta_keymap type as well, otherwise this patch
will introduce the following sparse warning:

   CHECK   arch/arm/mach-omap1/board-ams-delta.c
arch/arm/mach-omap1/board-ams-delta.c:191:27: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap1/board-ams-delta.c:191:27:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap1/board-ams-delta.c:191:27:    got int static [toplevel] *<noident>

I only checked E3, so other boards should be checked as well.

A.
