From: Tony Lindgren <tony@atomide.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 17:56:10 -0800
Message-ID: <20081212015610.GG10664@atomide.com>
References: <1228926833.32014.162.camel@localhost.localdomain> <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net> <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com> <20081211005733.GZ18138@atomide.com> <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com> <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com> <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com> <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com> <5e088bd90812111354w7633e2a3p1365ab35d43277b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57678 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809AbYLLB4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 20:56:14 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90812111354w7633e2a3p1365ab35d43277b9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@booyaka.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [081211 13:54]:
> On Thu, Dec 11, 2008 at 12:41 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> > On Thu, Dec 11, 2008 at 7:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> >> On Thu, Dec 11, 2008 at 8:49 AM, Paul Walmsley <paul@booyaka.com> wrote:
> >>> Hi Grazvydas, Steve,
> >>>
> >>> On Thu, 11 Dec 2008, Grazvydas Ignotas wrote:
> >>>
> >>>> > Can you please post whatever patches you need to apply to make it work
> >>>> > occasionally so others can also look at the issue?
> >>>>
> >>>> For pandora, making infinite while loops finite doesn't help much,
> >>>> kernel crashes later on. Steve had this too:
> >>>> http://marc.info/?l=linux-omap&m=122378604027303&w=2
> >>>>
> >>>> I did bisect and found that commit
> >>>> 8b1f0bd44fe490ec631230c8c040753a2bda8caa is causing the hang for me.
> >>>> Reverting this makes EHCI work again on pandora.
> >>>> http://marc.info/?l=linux-omap&m=122453174024860&w=2
> >>>
> >>> Would one of you be willing to run with this patch and send back any debug
> >>> output relating to dpll5_ck ?  (Unfortunately, I don't have access to any
> >>> boards with EHCI hardware, so cannot try it myself)
> >>>
> >>> This will help determine what fix should be applied
> >>
> >> Here you go.  Note that no infinite loop!
> >
> > Ah, so it no longer needs that revert, probably recent clock changes
> > fixed that issue.
> >
> >> ...
> >> Result: no hang at boot, but I still end up with the auto suspend,
> >> though the behavior is slightly different (dmesg output this time
> >> since it contains more debug info):
> >
> > If your host uses PHY mode, have you hacked EXT_PHY_RESET_GPIO* in
> > drivers/usb/host/ehci-omap.c? BTW, if this stuff is really needed, it
> > should go to platform_data..
> 
> I have hacked in the reset GPIO used on Overo.  I agree -- board
> specific stuff has no place in ehci-omap, it really should be platform
> data.

What's the patch you have for the GPIO? At least I don't seem to get
any VBUS on overo EHCI port.

<snip>

Regards,

Tony
