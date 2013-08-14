From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk
	info from DT
Date: Wed, 14 Aug 2013 14:57:55 +0100
Message-ID: <20130814135755.GC25647@n2100.arm.linux.org.uk>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com> <1374560679-14666-3-git-send-email-rnayak@ti.com> <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com> <520B8409.5000708@ti.com> <520B88A0.6080806@ti.com> <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41590 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352Ab3HNN7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 09:59:37 -0400
Content-Disposition: inline
In-Reply-To: <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, mturquette@linaro.org, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@gmail.com>, Rajendra Nayak <rnayak@ti.com>, tomasz.figa@gmail.com, rob.herring@calxeda.com, Tero Kristo <t-kristo@ti.com>, galak@codeaurora.org, grant.likely@linaro.org, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 14, 2013 at 02:49:04PM +0100, Mark Rutland wrote:
> [Adding Mike Turquette and dt maintainers]
> 
> On Wed, Aug 14, 2013 at 02:39:44PM +0100, Nishanth Menon wrote:
> > yes. the idea being, we now have a meaning to the clock name - there are 
> > two types of clocks here.. functional and optional, we *might* have 
> > facility to add interface clock(we dont know interface clock handling 
> > yet, but something in the future).. we might increase the support for 
> > number of functional clocks.. it might help to keep the format such that 
> > it is a "bit extendable".
> 
> I completely disagree. The only things that should appear in clock-names
> are the names of the clock inputs that appear in the manual for the
> device. The driver should know which ones are optional, as that's a
> fixed property of the IP and the way the driver uses it.
> 
> You should not be embedding additional semantics in name properties.

Agreed.  I've been on at people about this for years, and every time they
go off and do something else, it ultimately ends up coming back to bite
them.  Clock names _are_ the clock input names as far as device drivers
are concerned, and nothing else.

If there are optional clocks, then the driver should be doing as Mark
says - the driver should try to get them, and if it fails to get them
then they're quite simply not provided by the platform.  If there are
optional clocks which the device driver does not know about (or even
need to know about) then that too should not be a problem - the driver
just doesn't have to touch them.

If they're optional, but required for the device to function, then the
driver should get them and control them as necessary.
