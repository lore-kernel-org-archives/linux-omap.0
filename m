From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: HSMMC: Fix response type for busy after response
Date: Wed, 14 Jan 2009 12:19:55 +0200
Message-ID: <496DBC4B.2000609@nokia.com>
References: <20090113133827.29474.92645.sendpatchset@ahunter-laptop> <20090113133841.29474.15852.sendpatchset@ahunter-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16769 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZANKH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 05:07:56 -0500
In-Reply-To: <20090113133841.29474.15852.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Adrian Hunter wrote:
>>From 410bc62034c021f8767c8dae469c3215783992ca Mon Sep 17 00:00:00 200=
1
> From: Adrian Hunter <ext-adrian.hunter@nokia.com>
> Date: Mon, 12 Jan 2009 16:13:08 +0200
> Subject: [PATCH] OMAP: HSMMC: Fix response type for busy after respon=
se
>=20
> Some MMC commands result in the card becoming busy after
> the response is received.  This needs to be specified
> for the omap_hsmmc host controller, which is what this
> patch does.  However, the effect is that some commands
> with no data will cause a Transfer Complete (TC) interrupt
> in addition to the Command Complete (CC) interrupt.
> In order to deal with that, the irq handler has needed
> a few changes also.
>=20
> The benefit of this change is that the omap_hsmmc host
> controller driver now waits for the TC interrupt while
> the card is busy, so the mmc_block driver needs to poll
> the card status just once instead of repeatedly.
> i.e. the net result is more sleep and less cpu.
>=20
> This also fixes the hidden problem that the controller
> was turning off the clock to the card while the card
> was busy - the clock was then switched on for the
> duration of each Send Status command used for polling,
> which is why writes did not lock up altogether.
> i.e. really dysfunctional.

That paragraph is not true.  According to the standard:

"The host is allowed to shut down the clock of a =93busy=94 card. The c=
ard will complete the programming
operation regardless of the host clock. However, the host must provide =
a clock edge for the card to turn
off its busy signal. Without a clock edge the card (unless previously d=
isconnected by a deselect command
-CMD7) will force the DAT0 line down, forever."

i.e. during busy state the clock is only needed to check whether the bu=
sy state is over.

I will resend the patch, without that paragraph and with a fix to repor=
t the
error code when there is a timeout error in the busy state.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
