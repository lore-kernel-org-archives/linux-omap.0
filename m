From: David Brownell <david-b@pacbell.net>
Subject: RE: [PATCH] ARM: OMAP: Fix board data to support device only, host only and OTG roles.
Date: Thu, 20 May 2010 08:15:30 -0700 (PDT)
Message-ID: <304844.15257.qm@web180316.mail.gq1.yahoo.com>
References: <19F8576C6E063C45BE387C64729E7394044DCC5F46@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n3-vm0.bullet.mail.gq1.yahoo.com ([67.195.23.156]:26045 "HELO
	n3-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751084Ab0ETPPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 11:15:31 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DCC5F46@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik OjasMankad <x0082077@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ajay KumarGupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>


>  I think better remove .mode parameter from board_data if
> its not needed anyways

But it *IS* needed, as I explained before...



> if some board
>  supports only some specific mode they can select those
> specifc config only.

No they can't.  Recall that kernels are expected to run on
multiple boards.  Which means that the same kernel should be
able to work correctly on a board with a peripheral-only USB
connector ... and on a board with an OTG connector.  The way
to pass that information to the MUSB driver is through the
platform data.  On the peripheral-only config the host code
won't kick in.  On the OTG-enabled config, it will kick in
as needed (as will the peripheral mode).  And so on.

If you were to rely on Kconfig options, then at least one of
those boards would work incorrectly.  So that's not an option.


