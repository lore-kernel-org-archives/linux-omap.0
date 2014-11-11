From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: sbc-t3x: add DVI display data
Date: Tue, 11 Nov 2014 08:51:46 -0800
Message-ID: <20141111165145.GA26481@atomide.com>
References: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il>
 <1414927198-7127-1-git-send-email-lifshitz@compulab.co.il>
 <54561E45.7000404@compulab.co.il>
 <20141110174845.GP31454@atomide.com>
 <5461FAEF.3010607@compulab.co.il>
 <20141111144911.GK31454@atomide.com>
 <54623BC7.6000603@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32259 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaKKQw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2014 11:52:29 -0500
Content-Disposition: inline
In-Reply-To: <54623BC7.6000603@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [141111 08:41]:
> On 11/11/14 16:49, Tony Lindgren wrote:
> > * Igor Grinberg <grinberg@compulab.co.il> [141111 04:04]:
> >> Hi Tony,
> >>
> >> On 11/10/14 19:48, Tony Lindgren wrote:
> >>> * Igor Grinberg <grinberg@compulab.co.il> [141102 04:08]:
> >>>> On 11/02/14 13:19, Dmitry Lifshitz wrote:
> >>>>> Add DSS related pinmux and display data nodes required to support
> >>>>> DVI video out on SBC-T3530, SBC-T3730 and SBC-T3517.
> >>>>>
> >>>>> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> >>>>
> >>>> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> >>>
> >>> Thanks applying into omap-for-v3.19/dt.
> >>>
> >>> Are we now ready to drop the board-cm-*.c files?
> >>
> >> Let's see, below is a list of things that are yet to be
> >> supported in DT boot:
> >> NAND, TV, LCD, Touchscreen, Audio (CM-T3x30), RTC (CM-T3517), CAN (CM-3517).
> > 
> > OK great, hopefully that's mostly just configuring the .dts
> > files.
> 
> Well, mostly... but not all of it.
> 
> The LCD, RTC and CAN require bindings/drivers work.

OK 
  
> >> We're rc4 now, so hopefully, we will be able to get all this in for 3.19
> >> and then have the board files removed for 3.20.
> > 
> > Yes something like that sounds good to me. We should allow at
> > least one release for people to change over.
> > 
> >> This way we can have 3.19 with both ways supported and do last checks.
> >>
> >> Are you ok with this?
> > 
> > Sure if you get the changes posted before -rc6, otherwise
> > it will be too late for v3.19.
> 
> I think, I was too optimistic about 3.19, but we can try.
> Since drivers will require adaptation, I'm not sure
> it will be merged for 3.19...

Yes it might be a bit late for that, but if the changes are trivial,
maybe not.

> If we really want to make the DT boot for 3.19, we could work and
> post the drivers adaptation patches and in parallel (to keep thing
> going for board files removal) prepare patches for adding the
> problematic stuff via quirks. This way we can keep only the DT missing
> functionality in quirks and remove the board files. Once the drivers
> are adjusted with new bindings, we can remove the quirks.

Yes that's what we can do for sure.
 
> Or if we are fine with keeping the board files for a little more, then
> just add the DT functionality that is ready and keep working on drivers
> until they are ready (hopefully, 1 - 2 releases).
> 
> What do you think?

It seems we can do both in parallel: We can use quirks for now, then
remove the quirks when drivers have bindings. That removes a dependency
between board-*.c files and the remaining few drivers.

Regards,

Tony
