From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH] [OMAP1] use gen_nand
Date: Mon, 30 Nov 2009 21:23:00 +0100
Message-ID: <20091130202258.GA18203@localhost.localdomain>
References: <20091123124545.GA31420@localhost.localdomain> <20091123172416.GG15580@atomide.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:49726 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbZK3TXA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 14:23:00 -0500
Content-Disposition: inline
In-Reply-To: <20091123172416.GG15580@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Brian Swetland <swetland@google.com>, Kevin Hilman <kjh@hilman.org>

On Mon, Nov 23, 2009 at 09:24:16AM -0800, Tony Lindgren wrote:
> * Ladislav Michl <Ladislav.Michl@seznam.cz> [091123 03:45]:
> > Since omapnand driver never find its way into mainline, switch to gen_nand instead.
> > Following patch is compile tested only, but it is based on code I wrote for
> > NetStar board and runtime tested it there.
> 
> Nice patch, and totally the way to go!

Well, after one week of silence... Anything else I could do to get it merged?
Btw, these boards could probably use physmap-flash, so we could get rid of
omap_nor as well.

Best regards,
	ladis
