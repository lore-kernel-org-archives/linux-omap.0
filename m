From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: [PATCH 0/3] OMAP: PM: enable UART clock disabling when idle
Date: Mon, 01 Dec 2008 08:07:08 +0200
Message-ID: <1228111628.26105.15.camel@localhost>
References: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
	 <94a0d4530811290452o53df8811x697bcfa49660118a@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE8967162036CE50266@dlee02.ent.ti.com>
	 <1227974819.26105.6.camel@localhost>
	 <13B9B4C6EF24D648824FF11BE8967162036CE5028C@dlee02.ent.ti.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61110 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbYLAGMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 01:12:46 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036CE5028C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On Sat, 2008-11-29 at 21:35 -0600, ext Woodruff, Richard wrote:
> > From: Igor Stoppa [mailto:igor.stoppa@nokia.com]
> > Sent: Saturday, November 29, 2008 10:07 AM
> 
> > On Sat, 2008-11-29 at 07:55 -0600, ext Woodruff, Richard wrote:
> >
> > > Not unless you use some kind of flow control or protocol retransmits.
> >
> > What about bitbanging the entire first character?
> 
> Huh?
> 
> Typically for development you are just hooked to your PC.  It doesn't do anything special.

but for some reason there seemed to be people who did now want to loose
the first character, so i was wondering if the entire first character
could be bitbanged in gpio mode and put into the sw buffer for the
serial port, which would be reinserted into the foodchain after the
completion of the first character.

Of course in the case of human input it would probably mean that all the
characters could be bitbanged, if the timeout for entering low power
states is short enough, but wouldn't that be very close to reality
where, like in the internet tablets, the serial port is disabled in
production mode?

What we usually see is that during development as soon as we enable
production mode (iow no active serial port, not even with timeout) those
drivers which were relying on it to provide some sort of wakeup, fail.

Just a thought.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
