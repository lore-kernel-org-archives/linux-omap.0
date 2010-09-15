From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] overo twl4030: fix twl4030 IRQ (used for usb otg detection)
Date: Wed, 15 Sep 2010 14:28:57 -0700
Message-ID: <AANLkTimG7i72PdjaX-2_EqhJkZBFm==StMJZKkzywCf=@mail.gmail.com>
References: <4C90F46D.2020902@artecdesign.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44725 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab0IOVgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 17:36:44 -0400
Received: by wwd20 with SMTP id 20so8371wwd.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 14:36:43 -0700 (PDT)
In-Reply-To: <4C90F46D.2020902@artecdesign.ee>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anti Sullin <anti.sullin@artecdesign.ee>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

On Wed, Sep 15, 2010 at 9:29 AM, Anti Sullin <anti.sullin@artecdesign.ee> wrote:
> I was not getting OTG USB vbus/id pin change interrupts on Gumstix Overo
> and the reason was a mis-configured irq. I added some more checks to avoid
> having a non-bootable kernel on boards with bootloaders that have wrong pinmux.
> The changes of twl4030 should be tested on other boards too.
>
> ---
> Gumstix Overo has TPS65950 (TWL4030) IRQ1 connected to GPIO112.

I don't think that this change should be made.

>From what I understand from my discussions with Gumstix, early
versions of the Overo COM used GPIO112 as indicated above.

However all fab revisions >=2516 use GPIO0, so the code is correct for
current and future versions of Overo COMs (as is the bootloader
pinmuxing).

In fact, future versions of Overo will use GPIO112 for a revision ID.

Not an ideal situation, but I think we should leave things as they are
since it matches current and future production.

People with older boards will certainly need to use this patch to get
vbus/id interrupts.

Steve
