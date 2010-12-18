From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
Date: Fri, 17 Dec 2010 20:29:30 -0800
Message-ID: <AANLkTim3nFfo4PGf+krOJCsacxDuGyavvt4Pev3MWPj3@mail.gmail.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40442 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab0LRE3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 23:29:52 -0500
In-Reply-To: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org

On Fri, Dec 17, 2010 at 2:32 PM, Janusz Krzysztofik
<jkrzyszt@tis.icnet.pl> wrote:
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
> ---

Works perfectly on the herald, and no more warning message.  Good work!

Tested-by: Cory Maccarrone <darkstar6262@gmail.com>

- Cory
