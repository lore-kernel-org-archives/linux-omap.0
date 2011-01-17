From: Tony Lindgren <tony@atomide.com>
Subject: Re: State of LDP3430 platform
Date: Mon, 17 Jan 2011 09:34:54 -0800
Message-ID: <20110117173454.GX4957@atomide.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20101206181913.GH8345@atomide.com>
 <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
 <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <13B9B4C6EF24D648824FF11BE896716203EAE6F3AA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64546 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1AQRfJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 12:35:09 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203EAE6F3AA@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

* Woodruff, Richard <r-woodruff2@ti.com> [110115 15:48]:
> 
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Friday, January 14, 2011 6:03 PM
> 
> > I've been seeing this on my omap4 panda. While debugging it, I left
> > u-boot console only running for a few minutes to see if that stays up.
> > It did.. And after doing that somehow now my panda boots all the way
> > and stays up. Weird.
> 
> That is a bit weird.  U-boot doesn't do much of anything but spin waiting for characters on serial.  The watchdog normally isn't used.
> 
> Thinking back I have experienced goofiness along these lines before.  This had to do with some bad timer initial state assumptions.  The timer's count values and states entering the kernel have caused a trip up.  I had fixed some of these years back.  Its possible some could have snuck back with all the recoding.  Many times the simple have some unanticipated twist.
> 
> The watchdog is something which the old kernel used to fall on also.  There were a couple simple trip ups:
>         -1- people forgot to turn clock on all together
>         -2- next, it was touched before clock frame work was initialized
>         -1+2- some code only 'wrote' to watchdog registers.  When memory attribute is device, generally the imprecise abort is ignored by the arm.  But some times weirdness slipped in around memory weak memory attribute mishandling.
> 
> Sounds like a fun bug/puzzle which good ole Lauterbach would help in.

This happened for a few days both with 2.6.37 and current mainline
kernel. After I started debugging it went away with no changes to
anything.. So can't debug any further at this point unfortunately.

Regards,

Tony
