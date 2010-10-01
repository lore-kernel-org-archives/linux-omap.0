From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: Dropping omap3430 ES1.0 support in mainline
Date: Sat, 2 Oct 2010 03:58:13 +0530
Message-ID: <cf484f0b347742791af6d563efefaeb4@mail.gmail.com>
References: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com>
 <alpine.DEB.2.00.1010011558290.22941@utopia.booyaka.com> <3700cfbb0159d56cecbda0e06a2957e3@mail.gmail.com>
 <alpine.DEB.2.00.1010011615560.22941@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55326 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750902Ab0JAW2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 18:28:13 -0400
Received: by mail-ww0-f54.google.com with SMTP id 14so14476wwi.23
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 15:28:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1010011615560.22941@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Paul Walmsley wrote:
> On Sat, 2 Oct 2010, Anand Gadiyar wrote:
>
> > Okay, so we're aligned that you guys don't have an ES1 board to test,
> > and TI doesn't have any either. :)
> >
> > I'd still like to know if anyone in the wild still cares about the
board.
> >
> > (I see Tony already said "No thanks", but I'd like to know anyway).
>
> Why would we want to remove support for a board that should work fine
with
> linux-omap and isn't causing any problems with existing code?

I'm not sure it works fine, and if there are no users that care about
the board, then it would be nice to drop the support. If the board
works fine today, that's good, but has anyone tested the current
kernel on that board?

(we're struggling to keep linux-omap working on boards available now,
why support something that nobody cares about. It's not like I'm asking
3430 support to be dropped)

- the ES1 chip has never been available to the outside world beyond
sampling quantities
- no new developments are likely to happen on that board
- nobody's likely to have one of these around and care to boot it up
- there are plenty of replacements like the beagles which are lower
  cost, easier to obtain, and can beat an ES1 in speed

I'm okay having support for the board if someone's actually using it.
It's not such a big deal. It was just a thought - it came up because
Manju was looking at old errata docs, and came across something that
was specific to an ES1, but we realized there was no way to test it.

- Anand
