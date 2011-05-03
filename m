From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Tue, 3 May 2011 23:41:24 +0200
Message-ID: <BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com>
	<87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
	<87y62ng3f8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40350 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab1ECVlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 17:41:24 -0400
Received: by iwn34 with SMTP id 34so442019iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 14:41:24 -0700 (PDT)
In-Reply-To: <87y62ng3f8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>

2011/5/3 Kevin Hilman <khilman@ti.com>:

> Are you OK with a move of the current OMAP GPIO drivers (rather ugly)
> into drivers/gpio first, followed by the cleanup/restructure patches?

In my case I actually did some cleanup after moving the driver for
U300, but I think this is a question to the GPIO maintainer who
I want to ACK this stuff in the end.

Grant?

You can always squash it later ...

Linus Walleij
