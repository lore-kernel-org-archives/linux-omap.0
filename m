From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: State of LDP3430 platform
Date: Sat, 15 Jan 2011 17:47:50 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203EAE6F3AA@dlee02.ent.ti.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20101206181913.GH8345@atomide.com>
 <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
 <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab1AOXs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Jan 2011 18:48:58 -0500
In-Reply-To: <20110115000301.GT4957@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, January 14, 2011 6:03 PM

> I've been seeing this on my omap4 panda. While debugging it, I left
> u-boot console only running for a few minutes to see if that stays up.
> It did.. And after doing that somehow now my panda boots all the way
> and stays up. Weird.

That is a bit weird.  U-boot doesn't do much of anything but spin waiting for characters on serial.  The watchdog normally isn't used.

Thinking back I have experienced goofiness along these lines before.  This had to do with some bad timer initial state assumptions.  The timer's count values and states entering the kernel have caused a trip up.  I had fixed some of these years back.  Its possible some could have snuck back with all the recoding.  Many times the simple have some unanticipated twist.

The watchdog is something which the old kernel used to fall on also.  There were a couple simple trip ups:
        -1- people forgot to turn clock on all together
        -2- next, it was touched before clock frame work was initialized
        -1+2- some code only 'wrote' to watchdog registers.  When memory attribute is device, generally the imprecise abort is ignored by the arm.  But some times weirdness slipped in around memory weak memory attribute mishandling.

Sounds like a fun bug/puzzle which good ole Lauterbach would help in.

Regards,
Richard W.

