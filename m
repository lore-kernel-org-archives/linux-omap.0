From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: miscellaneous powerdomain-related
 improvements
Date: Tue, 31 Jan 2012 09:21:20 +0200
Message-ID: <1327994480.4102.44.camel@sokoban>
References: <20120130093931.11027.31048.stgit@dusk>  <871uqgswy8.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51505 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027Ab2AaHV0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 02:21:26 -0500
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

Yeah, I can test these out hopefully tomorrow / today, I am busy today
creating a release but lets see. :) The patches seem okay to me also at
least.

-Tero


