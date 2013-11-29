From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/12 diet] ARM: OMAP2+: Remove legacy omap3 board-*.c
 files and make mach-omap2 DT only for booting
Date: Fri, 29 Nov 2013 09:07:29 -0800
Message-ID: <20131129170729.GL31534@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <20131126011744.GA26766@atomide.com>
 <CANOLnONmmRgDSfdObUii-FxwVOTo45WGX81Lend7QGWuqXWaZA@mail.gmail.com>
 <CABxcv==5X91DTnUCOjZTpjKCVQzHquvL7o4+q0DsJ=LM80DORQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10989 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367Ab3K2RHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 12:07:33 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv==5X91DTnUCOjZTpjKCVQzHquvL7o4+q0DsJ=LM80DORQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Javier Martinez Canillas <javier@dowhile0.org> [131129 01:01]:
> Hi Grazvydas,
> 
> On Fri, Nov 29, 2013 at 12:57 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> > On Tue, Nov 26, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> We can now boot all mach-omap2 related boards using appended device
> >> tree by creating a related .dts file with pretty much the same
> >> functionality as booted in the legacy platform data mode.
> >
> > Not really the same, quite some drivers are still missing, and it
> > makes pandora unusable :( . For example, SDIO variation of wl1251,
> > that one is non-probeable and used to be "detected" by using
> > MMC_QUIRK_NONSTD_SDIO quirk (see pandora_wl1251_init_card() in
> > board-omap3pandora.c). Also there are at least pandora-backlight,
> > twl4030_keypad and panel drivers that are not converted yet.

Sounds like the pandora-backlight should be initialized using
pdata-quirks.c for now. Then Sebastian has posted some twl4030-keypad
patches at:

http://linux-kernel.2935.n7.nabble.com/PATCHv3-0-2-twl4030-keypad-DT-binding-td750095.html

Other than wl1251 below, looking at board-omap3pandora.c there should not
be anything that we could not support with device tree. It seems that
pandora can use the panel dpi pdata-quirks.c similar to the LDP.

> > Can pdata-quirks.c be used for SDIO wl1251 at least, as I have no idea
> > how to express it using device tree?
> >
> 
> Yes, pdata-quirks.c can be used to initialize any platform device that
> does not have DT support yet and still needs platform data. Until we
> add the proper bindings and get rid of it.

Yeah at least initially. It should be just a question of adding a
new entry to auxdata_quirks[] for pandora to populate the hsmmc
platform data, then also add a new entry to omap_auxdata_lookup[] for
hsmmc platform data. Similar to what n8x0 is already doing.

But ideally we'd completely get rid of the platform data for the
omap_hsmmc.c so we can simplify the driver and remove all the callback
functions.

So we could pass the non-standard configuration by adding a new
compatible flag to omap_hsmmc.c for ti,omap3-hsmmc-wl1251. Then based
on that omap_hsmmc.c could set the .init_card function from the
struct of_device_id match table in the driver. 

Or we could specify the non-standard SDIO card properties as a child
of the hsmmc .dts entry. But that can be done later on naturally and
should be discussed on the linux-mmc and device tree lists.

Let me know if you need help with the pandora .dts file, I don't have
a pandora, but doing the basic .dts file for it should be quite easy.

Regards,

Tony
