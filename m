From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Mon, 1 Jun 2015 13:54:20 -0700
Message-ID: <20150601205420.GE30984@atomide.com>
References: <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
 <20150601152111.GA14015@amd>
 <20150601174730.GA30024@dtor-ws>
 <20150601202740.GA6716@amd>
 <20150601204519.GA14395@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55211 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbbFAUyX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 16:54:23 -0400
Content-Disposition: inline
In-Reply-To: <20150601204519.GA14395@dtor-ws>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Maxime Ripard <maxime.ripard@free-electrons.com>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [150601 13:47]:
> On Mon, Jun 01, 2015 at 10:27:40PM +0200, Pavel Machek wrote:
> > On Mon 2015-06-01 10:47:30, Dmitry Torokhov wrote:
> > > On Mon, Jun 01, 2015 at 05:21:11PM +0200, Pavel Machek wrote:
> > > > 
> > > > 
> > > > > > > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> > > > > > > 
> > > > > > > You were very welcome to review this patch at the time and/or suggest
> > > > > > > a fix that pleases everyone.
> > > > > > 
> > > > > > You should be the one that should suggest fixes, as you broke it in
> > > > > > the first place. But clearly you don't understand that.
> > > > > 
> > > > > You actually never asked for a fix, and went head first calling this
> > > > > patch "bad" and asking for nothing but reverting it.
> > > > 
> > > > Date: Fri, 29 May 2015 21:08:16 +0200
> > > > Subject: 4.1 touchscreen regression on n900 -- pinpointed [was Re:
> > > > linux-n900
> > > > ...
> > > > Maxime, can you suggest a fix?
> > > 
> > > How about we do something like below (it needs a small edt-ft5x06 fixup
> > > that I'll send separately). Not tested.
> > 
> > +       data_present = touchscreen_get_prop_u32(np,
> > "touchscreen-size-x",
> > +
> > input_abs_get_maximum(axis),
> > +                                               &maximum) |
> > +                      touchscreen_get_prop_u32(np,
> > "touchscreen-fuzz-x",
> > +
> > input_abs_get_fuzz(axis),
> > +                                               &fuzz);
> > +       if (data_present)
> > +               touchscreen_set_params(dev, axis, maximum, fuzz);
> > 
> > Umm. So you are changing behaviour from "whatever was there" to
> > "input_abs_get_maximum"... in n900 case.o
> 
> That _is_ "whatever was there".
> 
> > Is that a good idea for a
> > regression fix this late in release cycle?
> 
> As Maxime mentioned the new behavior is needed for other touchscreens.
> Given that fixed DTS is going into 4.1 (as far as I understand) we do
> not need to rush this change into 4.1.

OK great. I'm planning to send a pull request to arm-soc for Pavel's
DTS fix today along with few other fixes.

Regards,

Tony
