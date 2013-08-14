From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Wed, 14 Aug 2013 18:41:09 +0200
Message-ID: <CACRpkdZXFv4JFek9SV1n=7gw0sLAeA_xxC1D+_OMLQyLYtXLvA@mail.gmail.com>
References: <20130716090310.5541.36777.stgit@localhost>
	<20130716090536.5541.36289.stgit@localhost>
	<51E70953.1000601@wwwdotorg.org>
	<20130718072034.GO7656@atomide.com>
	<51E8401E.8040705@wwwdotorg.org>
	<20130719072927.GY7656@atomide.com>
	<51E98AEC.5000802@wwwdotorg.org>
	<20130729090524.GY7656@atomide.com>
	<51F6E657.2060802@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F6E657.2060802@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 30, 2013 at 12:01 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> I was thinking more about people writing the device trees that define
> these states; they need to explicitly make the choice re: overlapping
> states or independent states. We should not plan to obsolete any current
> usage of overlapping states since that will mean an incompatible change
> to the DT ABI (deprecate yes so that no more usage is added, but the
> kernel should still support the old way).

This is another reason to not group and encode explicitly the pins
that remain unchanged during state transitions.

I prefer that either:

- when we build up the state containers in the subsystem,
 we identify overlapping pins and encode them in the state
 container somehow

or:

- when transitioning from state A -> state B we identify
 ovelapping pins or groups of pins and do not touch them
 by making calls down to the driver ->free() and ->request()
 callback pair.

or:

the pinctrl-single.c driver in it's callbacks like ->enable()
->disable(), ->request(), ->free() internally short cuts from
its knowledge of such pin shortcuts and no other drivers
are affected (nor helped) by this optimization.

Yours,
Linus Walleij
