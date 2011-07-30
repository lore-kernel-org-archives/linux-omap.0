From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sat, 30 Jul 2011 23:36:06 +0200
Message-ID: <201107302336.06428.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org> <201107302309.19169.rjw@sisk.pl> <20110730212523.GA10450@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35856 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab1G3Veo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Jul 2011 17:34:44 -0400
In-Reply-To: <20110730212523.GA10450@elf.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Saturday, July 30, 2011, Pavel Machek wrote:
> 
> > > > IIRC I solved it by just calling _PTS when sleepy Linux was
> > > > enabled. It had side effect of lighting up moon icon, but otherwise
> > > > seemed to work ok.
> > > > 
> > > > I do not think ACPI says what can and can not be done after _PTS...
> > > 
> > > Yes, it does.
> > 
> > And even if _PTS will work, you're certainly not supposed to execute _WAK
> > with interrupts off.
> 
> It should be ok to execute _WAK in process context once system is
> resumed. ... or maybe not executing _WAK at all. User can probably
> live with moon icon lighted up.

But I don't think the user can live with certain functionality missing,
like battery status or such things.

This is completely unrealistic to think that your prototype can be safely
implemented on _every_ ACPI-based system.  Period.

And that's even without taking SMP into account, BTW.

Thanks,
Rafael
