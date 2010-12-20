From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2] Keyboard: omap-keypad: use matrix_keypad.h
Date: Mon, 20 Dec 2010 19:49:26 +0100
Message-ID: <201012201949.28639.jkrzyszt@tis.icnet.pl>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl> <201012201832.24243.jkrzyszt@tis.icnet.pl> <20101220180207.GD9353@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20101220180207.GD9353@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Monday 20 December 2010 19:02:08 Dmitry Torokhov wrote:
>
> Not sure why exactly your sparse does not pick it up (too old maybe?)
> but the following:
>
> --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig 2010-12-09 23:07:35.000000000 +0100
> +++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c 2010-12-18
> 16:23:29.000000000 +0100
> @@ -46,81 +46,79 @@ static u16 ams_delta_latch2_reg;
>  static int ams_delta_keymap[] = {
>         KEY(0, 0, KEY_F1),              /* Advert    */
>
> should be
>
>  static const unisgned int ams_delta_keymap[] = {
>
> Same goes for the rest of keymaps.

Sure, thanks.
Janusz
