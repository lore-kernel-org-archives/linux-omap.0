From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2] Keyboard: omap-keypad: use matrix_keypad.h
Date: Mon, 20 Dec 2010 18:32:22 +0100
Message-ID: <201012201832.24243.jkrzyszt@tis.icnet.pl>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl> <201012181639.29820.jkrzyszt@tis.icnet.pl> <alpine.DEB.1.10.1012201720470.13087@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:58592 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab0LTRfC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 12:35:02 -0500
In-Reply-To: <alpine.DEB.1.10.1012201720470.13087@esdhcp041196.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

Monday 20 December 2010 16:29:32 Aaro Koskinen wrote:
> Hello,
>
> On Sat, 18 Dec 2010, Janusz Krzysztofik wrote:
> > Most keypad drivers make use of the <linux/input/matrix_keypad.h>
> > defined macros, structures and inline functions.
> >
> > Convert omap-keypad driver to use those as well, as suggested by a
> > compile time warning, hardcoded into the OMAP <palt/keypad.h>.
> >
> > Created against linux-2.6.37-rc5.
> > Tested on Amstrad Delta.
> > Compile tested with omap1_defconfig and omap2plus_defconfig
> > shrinked to board-h4.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> [...]
>
> > --- linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig
> > 2010-12-09 23:07:35.000000000 +0100 +++
> > linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c     
> > 2010-12-18 16:23:29.000000000 +0100 @@ -46,81 +46,79 @@ static u16
> > ams_delta_latch2_reg;
> > static int ams_delta_keymap[] = {
>
> [...]
>
> > +static const struct matrix_keymap_data ams_delta_keymap_data = {
> > +       .keymap         = ams_delta_keymap,
> > +       .keymap_size    = ARRAY_SIZE(ams_delta_keymap),
> > +};
>
> You should update the ams_delta_keymap type as well, otherwise this
> patch will introduce the following sparse warning:
>
>    CHECK   arch/arm/mach-omap1/board-ams-delta.c
> arch/arm/mach-omap1/board-ams-delta.c:191:27: warning: incorrect type in initializer (different signedness)
> arch/arm/mach-omap1/board-ams-delta.c:191:27:    expected unsigned int const [usertype] *keymap
> arch/arm/mach-omap1/board-ams-delta.c:191:27:    got int static [toplevel] *<noident>

Hi Aaro,
How did you get this output? I'm using OpenEmbedded as my development 
environment. Running make with "C=1" (EXTRA_OEMAKE=" C=1 ") displays a 
lot but the above. Running sparse by hand breaks with "unable to 
open 'linux/init.h'". Any advice?

Thanks,
Janusz
