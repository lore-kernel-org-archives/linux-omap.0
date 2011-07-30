From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sat, 30 Jul 2011 23:05:00 +0200
Message-ID: <201107302305.00212.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org> <201107292152.27066.rjw@sisk.pl> <20110730203737.GA8762@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35816 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700Ab1G3VDk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Jul 2011 17:03:40 -0400
In-Reply-To: <20110730203737.GA8762@elf.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Saturday, July 30, 2011, Pavel Machek wrote:
> Hi!
> 
> > > Well, auto suspending when screensaver is active would still be
> > > useful.
> > > 
> > > (And IIRC some machines kept screen on when in S-state unless driver
> > > powered it down... but that might be S1.
> > > 
> > > > The reason why you can't enter ACPI S-states from CPUidle is because you
> > > > need to go out of the idle loop to execute some ACPI-specific stuff.  Which
> > > > is not even specific to Intel chips, but to ACPI in general.
> > > 
> > > The code was little tricky/unclean, but it "worked" for me at one
> > > point... I called it  "sleepy linux".
> > 
> > Yes, you can find a system where it might kind of work (just because
> > _PTS is empty or something like this).  Is it going to work in general?
> > No way.
> 
> IIRC I solved it by just calling _PTS when sleepy Linux was
> enabled. It had side effect of lighting up moon icon, but otherwise
> seemed to work ok.
> 
> I do not think ACPI says what can and can not be done after _PTS...

Yes, it does.

Thanks,
Rafael
