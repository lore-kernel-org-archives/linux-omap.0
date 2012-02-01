From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: miscellaneous powerdomain-related
 improvements
Date: Wed, 1 Feb 2012 15:55:22 +0200
Message-ID: <1328104522.4102.123.camel@sokoban>
References: <20120130093931.11027.31048.stgit@dusk>  <871uqgswy8.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55050 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab2BANz2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 08:55:28 -0500
In-Reply-To: <871uqgswy8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, 2012-01-30 at 13:27 -0800, Kevin Hilman wrote:
> Paul Walmsley <paul@pwsan.com> writes:
> 
> > This series optimizes some of the powerdomain-related code in
> > arch/arm/mach-omap2/pm*, and fixes a bug or two.  These were noticed while
> > working on the functional powerstate code.
> >
> > Rajendra and Santosh, if you have a spare moment, could you please
> > peek at the OMAP4 LOWPOWERSTATECHANGE part of the second patch?  It
> > makes sense to me in theory, but you both would probably know better
> > than I :-)
> >
> > Kevin, want to take this series (assuming folks are happy with it) ?
> 
> Yes, I'll take this and add the Ack from Santosh.  Thanks for the nice
> cleanup.   
> 
> Will submit after seeing a Tested-by from someone who can test with CORE
> retention/off on OMAP4 (hint, hint,  Tero :)

The patches appear to behave nicely on omap4, there are still a couple
of quirks in the basic omap4 support though. l3init pd state is not
updated properly once we wake-up from device-off (it remains active for
a short while during wake-up before switching to idle with hwauto), and
cpu1 pwrdm state is not updated properly during hotplug, but these are
minor issues and should be fixed elsewhere.

You can add:

Tested-by: Tero Kristo <t-kristo@ti.com>

> 
> Kevin


