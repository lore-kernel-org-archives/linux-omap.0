From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH 1/2] omap4: 4430sdp: drop ehci support
Date: Thu, 17 Feb 2011 19:34:51 +0530
Message-ID: <9384e5030701b4680b09f7ad49190054@mail.gmail.com>
References: <1297855040-1337-1-git-send-email-gadiyar@ti.com> <20110217114916.GA24989@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:48566 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756499Ab1BQOEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 09:04:55 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2585060fxm.16
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 06:04:52 -0800 (PST)
In-Reply-To: <20110217114916.GA24989@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Keshava Munegowda <keshava_mgowda@ti.com>

Russell King - ARM Linux wrote:
> On Wed, Feb 16, 2011 at 04:47:19PM +0530, Anand Gadiyar wrote:
> > Most revisions of the OMAP4 Blaze/SDP platform do not have
> > the EHCI signals routed by default. The pads are routed
> > for the alternate HSI functionality instead, and explicit
> > board modifications are needed to route the signals to
> > the USB PHY on the board.
> >
> > Also, turning on the PHY connected to the EHCI port causes
> > a board reboot during bootup due to an unintended short
> > on the rails - this affects many initial revisions of the
> > board, and needs a minor board mod to fix (or as a
> > workaround, one should not attempt to power on the
> > USB PHY).
>
> It's probably a good idea to put some comment in the code to that
> effect - people don't generally look at the history when adding new
> features.

I did part of this in patch 2/2.
I've muxed the pad in "safe mode" which turns off the output drivers
for the pad - so it can no longer drive a 1.

I've also placed a big warning above that line explaining why.

> It's probably also a good idea to claim the GPIO for the
> PHY power control and ensure that it's set to 'off' mode - that code
> can then be a placeholder for the comment.

This is a good idea too. Tony, if you concur, I'll go
respin this series.

- Anand
