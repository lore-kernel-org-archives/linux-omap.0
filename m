From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP1: clock_data: use runtime cpu / machine checks
Date: Mon, 13 Dec 2010 02:24:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
References: <201012112150.33831.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57185 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab0LMJZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 04:25:00 -0500
In-Reply-To: <201012112150.33831.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hello Janusz, Cory,

On Sat, 11 Dec 2010, Janusz Krzysztofik wrote:

> Otherwise multi-omap1 configurations may set wrong clock speed.
> 
> Created and tested against l-o master on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Thanks, this is a significant step forward in building a good 
omap1_defconfig.  Cory, do you mind testing this out?  If it works for you 
also, let's plan to take this for 2.6.38.

However:

> Tested with omap1_defconfig after dropping 
> CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=y and those of 12MHz xtal based 
> clock speeds which are too high for my board.

This is also key.  Until the board files can somehow indicate which rate 
sets are usable for their boards at runtime -- which is what the 
CONFIG_OMAP_ARM* KConfig options used to do at KConfig-time -- I don't 
think omap1_defconfig is possible yet.

Volunteers to tackle that project are gladly welcome :-)


- Paul
