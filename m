From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: MMC/SD cards hotplug scenario
Date: Thu, 22 May 2008 21:01:23 +0100
Message-ID: <20080522200123.GS15328@flint.arm.linux.org.uk>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com> <20080521073017.GB23427@flint.arm.linux.org.uk> <005d01c8bb25$63345fe0$538918ac@ent.ti.com> <20080521203202.6d84a02b@mjolnir.drzeus.cx> <0680EC522D0CC943BC586913CF3768C0015799CFD8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57016 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbYEVUBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 16:01:51 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0015799CFD8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: Pierre Ossman <drzeus@drzeus.cx>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, May 23, 2008 at 01:16:39AM +0530, Syed Mohammed, Khasim wrote:
> > The obscene amount of noise here seems to be caused by ext2 being
> > extremely persistent. This is generally a good thing for your data
> > though. :)
> >
> > What is missing is a decent way for a block device to tell the upper
> > layers that is gone with no hope of ever coming back. Right now we just
> > tell it that there was a write error, which just makes the upper layers
> > retry and retry.
> >
> In this scenario, do you think it would be right to kill the ongoing
> copy from application space, say for example an UI is running for MMC
> copy and when the card is removed the app gets notified may be through
> hotplug event or signaling and then app just kills the process that is
> issuing this copy request. This will prevent long running errors. Just
> a thought,

If you pick out the errors from 'cp', you'll see that the system is
telling 'cp' that it's getting IO errors.  Nevertheless, 'cp' carries
on trying to copy each file (and rightfully so.)

However, there is another issue here - if you're going to be ejecting
a medium containing an ext2fs filesystem at some random point, you
absolutely must run e2fsck before remounting it - the filesystem _will_
be in an inconsistent state at the point you eject the card.

Moreover, I wouldn't be surprised if you keep doing this with a card,
that the card's firmware will eventually get confused and die.

Basically, what I'm trying to say is that ejecting any medium randomly
from the system is _always_ going to result in problems of some nature.
Some of which you can reduce the impact from, others are fairly terminal.
The only safe solution is the unmount, wait for data to be written, and
then eject the card.
