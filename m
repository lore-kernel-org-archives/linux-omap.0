From: Tony Lindgren <tony@atomide.com>
Subject: Re: Merge plans for 2.6.33 merge window
Date: Thu, 3 Dec 2009 10:44:54 -0800
Message-ID: <20091203184454.GS4348@atomide.com>
References: <20091203173559.GR4348@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FAA0C54F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51361 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbZLCSov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 13:44:51 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C54F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [091203 10:27]:
> Tony
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> >Lindgren
> >Sent: Thursday, December 03, 2009 11:36 AM
> >To: linux-omap@vger.kernel.org
> >Subject: Merge plans for 2.6.33 merge window
> >
> >Hi all,
> <snip>
> >Then there are some new board files, like
> >touchbook and various fixes.
> 
> 3630 board support (zoom3/sdp3630) is already integrated in for-next.
> However the only pending patches missing for 3630 boards to boot are these serial patches:
> 	http://patchwork.kernel.org/patch/61671/
> 	http://patchwork.kernel.org/patch/61672/
> 
> Now there has been much discussion on the approach (errata vs feature).
> As a moderator, how would you like us to proceed on this?

The best solution way would be to check the revision register for the
serial module if available and then initialize the serial port
accordinly.

If this feature cannot be checked in the serial module, and is only
needed during the serial init, you might as well implement the test
in arch/arm/mach-omap2/serial.c. So probably no need to add that to
id.c.

Regards,

Tony
