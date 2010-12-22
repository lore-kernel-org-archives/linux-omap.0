From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Keyboard: omap-keypad: use matrix_keypad.h
Date: Wed, 22 Dec 2010 02:16:57 -0800
Message-ID: <20101222101657.GD22590@core.coreip.homeip.net>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
 <201012181639.29820.jkrzyszt@tis.icnet.pl>
 <alpine.DEB.1.10.1012201720470.13087@esdhcp041196.research.nokia.com>
 <201012202209.24068.jkrzyszt@tis.icnet.pl>
 <alpine.DEB.1.10.1012211150410.22164@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52869 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0LVKRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 05:17:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1012211150410.22164@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

On Tue, Dec 21, 2010 at 01:20:35PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, 20 Dec 2010, Janusz Krzysztofik wrote:
> >Most keypad drivers make use of the <linux/input/matrix_keypad.h>
> >defined macros, structures and inline functions.
> >
> >Convert omap-keypad driver to use those as well, as suggested by a
> >compile time warning, hardcoded into the OMAP <palt/keypad.h>.
> >
> >Created against linux-2.6.37-rc5.
> >Tested on Amstrad Delta.
> >Compile tested with omap1_defconfig and omap2plus_defconfig shrinked to
> >board-h4.
> >
> >Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> 

Acked-by: Dmitry Torokhov <dtor@mail.ru>

Thanks for making the changes.

-- 
Dmitry
