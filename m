From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH 0/2] TWL: USB: Start using twl4030/5030 regulator driver
Date: Fri, 20 Feb 2009 10:56:20 +0200
Message-ID: <1235120180.17391.251.camel@ubuntu>
References: <> <1234349235.17391.104.camel@ubuntu>
	 <1234519020.17391.167.camel@ubuntu>
	 <200902131435.58674.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gate.edelkey.net ([213.138.147.140]:33686 "EHLO
	gate.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbZBTI4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 03:56:38 -0500
In-Reply-To: <200902131435.58674.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: lrg@slimlogic.co.uk, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, jouni.hogander@nokia.com, broonie@sirena.org.uk

On Fri, 2009-02-13 at 14:35 -0800, David Brownell wrote:
> On Friday 13 February 2009, Kalle Jokiniemi wrote:
> > I ran into some trouble with the merged fix. For some reason clearing
> > the VUSB3V1_DEV_GRP register causes VUSB_DEDICATED2.VUSB3V1_SLEEP bit to
> > be enabled. This means that once VUSB3V1_DEV_GRP is put back to enabled
> > state (VUSB3V1 changed to be part of P1 group again), VUSB3V1 does not
> > go ACTIVE, but SLEEP state instead.
> > 
> > Anyone have a clue what might cause this?
> 
> Curious.  No ... is that specific to some TWL revision?

TWL5030, I think the revision is ES1.0.

I got additional info from TI that when the LDO goes into off state, the
sleep bit indeed resets back to default value of 1. Which is to remap
active state to sleep. So I have a patch that takes this into account by
clearing the remap bit every time we wake up the VUSB3V1 regulator.

- Kalle

> 
> I'll poke around after I get this new board working better for me.
> 
> - Dave
