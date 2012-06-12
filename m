From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 12 Jun 2012 11:50:24 +0100
Message-ID: <WC20120612105024.5601BD@terrafix.co.uk>
References: <1336982138.2532.32.camel@lappyti> <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com> <1337159300.7692.22.camel@deskari> <alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com> <1337934288.2842.19.camel@deskari> <CAORVsuWrWXFR7cnBGD+R4omKRjCCvkhHhOVhR_tj=gjA0tUyVA@mail.gmail.com> <WC20120612101510.1001B1@terrafix.co.uk> <1339497424.2392.22.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:46478 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751884Ab2FLKuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 06:50:50 -0400
In-Reply-To: <1339497424.2392.22.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

-----Original Message-----
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-
omap@vger.kernel.org
Date: Tue, 12 Jun 2012 13:37:04 +0300
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)

> On Tue, 2012-06-12 at 11:15 +0100, Joe Woodward wrote:
> > Was there ever a conclussion to this discussion?
> > 
> > I'm assuming this is unlikely to be fixed in 3.5?
> 
> If by conclusion you mean full understanding and a proper fix, then no.
> 
> But the patch 3568f2a46f2a73bab18c914df06afd98a97e0e0e (OMAPDSS: use
> DSI_FIFO_BUG workaround only for manual update displays) has been
> merged, and that should circumvent the problem.
> 
> Are you still seeing problems?

I haven't tested any kernels since 3.4, I normally wait till a later rc and had missed that patch...

If I have any problems I'll report them, but assume it's fixed otherwise.

Thanks for all the work on getting round this!

Cheers,
Joe

> 
>  Tomi
> 


