From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the
 display options
Date: Thu, 28 Mar 2013 09:53:37 -0700
Message-ID: <20130328165336.GW10155@atomide.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
 <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com>
 <51546B2C.2030101@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24617 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757150Ab3C1Qxk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 12:53:40 -0400
Content-Disposition: inline
In-Reply-To: <51546B2C.2030101@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

* Igor Grinberg <grinberg@compulab.co.il> [130328 09:13]:
> On 03/28/13 14:49, Tomi Valkeinen wrote:
> > Boards with multiple display options for the same video bus have all the
> > possible linux display devices present at the same time. Only one of
> > those devices should be used at a time, as the video bus cannot be
> > shared.
> 
> Yes, only one can be used at a time, but you can switch at runtime...
> 
> > 
> > This model is hacky, and will be changed in the forthcoming DSS patches
> > to a model where only one display device can be present on a single
> > video bus.
> 
> What do you mean by "present"?
> Is it active? or registered? or compiled in?
> 
> > 
> > This patch creates Kconfig options to select which of the display
> > devices is present on the board. While this model is also somewhat
> > hacky, and prevents us from using a single kernel image for all the
> > display options, it allows us to make the DSS driver changes for DT
> > adaptation. And with DT, the information about display devices can be
> > passed from the bootloader, solving the mess.
> 
> Hmmm, the fact that we cannot use the same binary for multiple displays...
> This does not sound right and good at all...
> While we try to move to support multiple platforms in the same binary, we
> cannot support multiple displays? I agree that the multiplatform stuff is
> not really related, but you know what I mean...

Yes that's not nice from usability point of view. Can we still switch
between LCD and DVI during the runtime? I thought the issue was registering
multiple LCD panels where only one can exist at a time?
 
> I bet there must be a much better solution for DT support.

Well the best legacy support option would be some fbdev/panel generic cmdline
option to specify which one to use. Maybe there is already something like
that available that the board-*.c files can parse and can be used also
later on with DT support to specify the preferred output?

What we don't want to do is add a board specific cmdline option as the
board-*.c files will be going away as soon as DT is usable for us and we
don't want to support a board specific cmdline after that. But if it's
a generic option then parsing it in the board-*.c file or the driver later
on can be supported.

Of course for some cases it might be possible to detect the configured
panel based on what's plugged in over i2c.

Regards,

Tony
