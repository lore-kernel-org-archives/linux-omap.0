From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
Date: Wed, 16 May 2012 09:14:47 +0200
Message-ID: <CACRpkdZCJXy4EMCa0x8pOLUOz=646_housV8qyqMh9AgfwxxUw@mail.gmail.com>
References: <20120503065131.GA3738@game.jcrosoft.org>
	<20120503152708.GC5140@atomide.com>
	<4FA30805.5050804@wwwdotorg.org>
	<20120504044305.GD7788@game.jcrosoft.org>
	<20120504150342.GI5140@atomide.com>
	<20120504153251.GE7788@game.jcrosoft.org>
	<20120504163420.GA5613@atomide.com>
	<4FA42631.6060304@wwwdotorg.org>
	<20120504220809.GW5613@atomide.com>
	<4FAAD141.3090306@wwwdotorg.org>
	<20120509204925.GV5088@atomide.com>
	<4FABF553.20601@wwwdotorg.org>
	<CACRpkdbqjofEi-5J+GTMOXFK1VvbXqa6At1fKXCge+5_y6aaRA@mail.gmail.com>
	<4FB1513A.4070002@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51172 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759460Ab2EPHOt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 03:14:49 -0400
Received: by qadb17 with SMTP id b17so4259146qad.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 00:14:48 -0700 (PDT)
In-Reply-To: <4FB1513A.4070002@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 14, 2012 at 8:38 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/12/2012 05:49 PM, Linus Walleij wrote:
>>
>> We have some pinctrl drivers implementing gpiolib too already,
>> and it's unavoidable I think, as some recent discussion about
>> matcing struct gpio_chip and pinctrl GPIO ranges shows.
>
> I strongly believe we should only do this when the exact same HW module
> is both pinctrl and GPIO.

Yep so this is what I have done for pinctrl-nomadik.c

> When there are separate HW modules, we should have separate drivers. The
> fact that the two drivers need to co-ordinate with each-other isn't a
> good argument to make them one driver.

So this matches the pinctrl-u300.c/pinctrl-coh901.c design pattern.

>> Maybe "-simple" isn't such a good name for this thing. Noone thinks
>> any kind of pin control is simple in any sense of the word anyway :-D
>>
>> Tony, would pinctrl-dt-only.c be a better name perhaps?
>
> That might be OK for the filename, but it doesn't seem like a useful
> change for the DT compatible value.

Oh I didn't think of these. Hm from a generic world running Windows
Mobile etc I take it that this is seen as simple mappings then?

Yours,
Linus Walleij
