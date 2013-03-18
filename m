From: Pavel Machek <pavel@denx.de>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Mon, 18 Mar 2013 17:36:53 +0100
Message-ID: <20130318163648.GA3722@amd.pavel.ucw.cz>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130222160044.GA16357@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54603 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab3CRQg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Mar 2013 12:36:56 -0400
Content-Disposition: inline
In-Reply-To: <20130222160044.GA16357@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, "Rini, Tom" <trini@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Fri 2013-02-22 08:00:44, Olof Johansson wrote:
> On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> > Any comments on this approach? Is it better to merge mkfitsrc.sh with
> > mkuboot.sh?
> 
> I know this was discussed quite extensively yesterday, but here is my take on
> it:
> 
> Given the recent complications from multiplatform, we really saw a strong
> reason to _not_ do the final boot wrapping in the kernel build system.
> Produce the zImage and the DTB files, and have a surrounding script that
> bundles the two in a format that your particular device needs.
> 
> Most distros have scripts to handle the "make install" step of a kernel build.
> That's where this belongs, not in the actual build step.

Not sure I agree here:

1) zImage was designed to boot from floppy, without any kind of
bootloader on i386

2) There are no distributions on many embedded systems. And no good
place where to store the scripts.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
