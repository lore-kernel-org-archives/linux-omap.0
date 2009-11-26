From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Series short description
Date: Thu, 26 Nov 2009 00:27:33 -0800
Message-ID: <20091126082732.GI4348@atomide.com>
References: <20091126001646.1546.34352.stgit@localhost>
 <0d7101ca6e63$f5b88a10$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55105 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759699AbZKZI1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 03:27:33 -0500
Content-Disposition: inline
In-Reply-To: <0d7101ca6e63$f5b88a10$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [091125 22:44]:
> ----- Original Message ----- From: "Tony Lindgren"
> <tony@atomide.com>
> To: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-omap@vger.kernel.org>
> Sent: Thursday, November 26, 2009 5:48 AM
> Subject: [PATCH 0/8] Series short description
> 
> 
> >Hi all,
> >
> >Here are some omap mux updates for review. These
> >are intended for the v2.6.33 merge window.
> >
> >Initially this series changes the omap34xx mux
> >code, I'm planning on adding 3630, 2420, and 2430
> >code later on.
> >
> >There are several reasons why we need better mux
> >code:
> >
> >- We want to make the mux code more generic and this
> > will allow us to use the internal signal names and
> > gpio numbers instead of mux register offsets. The
> > internal signal names stay the same across omap
> > generations for some devices.
> >
> >- We need to map mux registers to GPIO registers for
> > dynamic muxing of the GPIO pins during off-idle.
> >
> >- We want to be able to override the bootloader mux
> > values for the modded boards, such as the Beagle.
> >
> >- We want to have the mux signals and balls available
> > under debugfs for debugging new drivers.
> 
> Does it also detect conflicts when two drivers try
> to step on each other and overwrite the mux settings of
> other. SPI and EHCI was one of the problems I faced.
 
It does not, but that could be added by adding a
usecount to struct omap_mux.

In fact it's already a problem with the cmdline mux
options as that does not prevent other init code from
muxing over the cmdline options.

But then again, just being able to override the
bootloader settings might do the trick for most people
customizing their Beagle boards.

Currently we're not checking the return values for
muxing, so adding a usecount sounds like a follow-up
patch after these changes.

Regards,

Tony
