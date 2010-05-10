From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [RESEND PATCHv3 0/4] Adding soc related info into /proc/cpuinfo
Date: Mon, 10 May 2010 13:33:19 +0300
Message-ID: <20100510103319.GA8441@besouro.research.nokia.com>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
 <20100505085932.GA7703@n2100.arm.linux.org.uk>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36237 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab0EJKbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 06:31:09 -0400
Content-Disposition: inline
In-Reply-To: <20100505085932.GA7703@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

Hello,

So, back to this track.

On Wed, May 05, 2010 at 10:59:32AM +0200, Russell King wrote:
> On Wed, May 05, 2010 at 11:42:04AM +0300, Eduardo Valentin wrote:
> > I'm resending this series with minor change in the subject prefix of patch 4/4.
> > Removed the PM: prefix. Everything else is same. So, I kept the v3 prefix as well.
> 
> I'd much prefer to see a /proc/socinfo rather than extending
> /proc/cpuinfo to further include stuff which isn't CPU related.


Right. I agree that this is not CPU stuff. But I was trying to do not add new interfaces
to export those bits.

But the socinfo is actually a nice idea. I will resend this series, but now it will create the
socinfo and use it.

As it adds new stuff under /proc, I'll also cc lkml.

Thanks for the suggestion.

BR,


--
Eduardo Valentin
