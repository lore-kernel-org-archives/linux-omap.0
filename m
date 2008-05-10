From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [beagleboard] Re: TWL4030 intermittent freakout on boot
Date: Sat, 10 May 2008 09:57:35 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290447A000@dlee13.ent.ti.com>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com> <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl> <20080508182807.GE24454@atomide.com> <48249322.4060004@googlemail.com> <20080509213608.GA5976@atomide.com> <5e088bd90805091611q4a8a22d0l3dab427fe644a990@mail.gmail.com> <48256CDE.6040600@googlemail.com> <5e088bd90805100642s2ddf4048he6b01cc7a07e736e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56133 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYEJO5v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 10:57:51 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5e088bd90805100642s2ddf4048he6b01cc7a07e736e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, Dirk Behme <dirk.behme@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, beagleboard@googlegroups.com, Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, felipe.balbi@nokia.com, peter.de-schrijver@nokia.com

Hi,

> A grep of u-boot sources for the OMAP3 EVM does not yield any
> occurrences of twl403 so you might be on to something with this
> theory!

Your SYS_BOOT line values make a difference in TWL behavior.  The mask ROM knows specifics about this companion chip.

One aspect people seem to miss is the fact that the mask ROM will touch T2 based on the boot order.  The mask ROM also monkeys with some internal clocks and modules.

So, just because your x-loader or u-boot doesn't touch a register that doesn't mean the mask ROM hasn't.  So don't expect reset value.

Regards,
Richard W.
