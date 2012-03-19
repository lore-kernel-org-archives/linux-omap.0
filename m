From: Tony Lindgren <tony@atomide.com>
Subject: Re: smsc911x on Gumstix Overo/Tobi doesn't work
Date: Mon, 19 Mar 2012 15:51:31 -0700
Message-ID: <20120319225131.GE9859@atomide.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <20120316193337.GE7276@atomide.com>
 <4F675D9D.2040102@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59473 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965087Ab2CSWvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 18:51:33 -0400
Content-Disposition: inline
In-Reply-To: <4F675D9D.2040102@uni-dortmund.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Klute <thomas2.klute@uni-dortmund.de>
Cc: linux-omap@vger.kernel.org

* Thomas Klute <thomas2.klute@uni-dortmund.de> [120319 09:26]:
> Am 16.03.2012 20:33, schrieb Tony Lindgren:
> > Hi,
> > 
> > * Thomas Klute <thomas2.klute@uni-dortmund.de> [120316 05:08]:
> >> Hi,
> >>
> >> I have trouble getting the Ethernet port on a Gumstix Overo with Tobi
> >> expansion board to work with current kernel versions. With the latest
> >> commit from linux-omap git (b8fe1781ec8bed5e086691a827a6ee11facec2aa),
> >> the output from loading the smsc911x driver is as follows:
> >>
> >> du14:~# modprobe smsc911x
> >> [  254.843811] smsc911x: Driver version 2008-10-21
> >> [  254.854553] smsc911x: Driver version 2008-10-21
> >> [  254.859588] _regulator_get: smsc911x.1 supply vdd33a not found, using
> >> dummy regulator
> >> [  254.868377] _regulator_get: smsc911x.1 supply vddvario not found,
> >> using dummy regulator
> >>
> >> "ip link show" does not show any available Ethernet port.
> > 
> > The first instance one should work the same way as earlier using
> > fixed regulator in gpmc-smsc911x.c. Is it not working for you
> > somehow? At least it works for me on zoom3.
> 
> The Tobi board has only one Ethernet port.
> 
> >> I know there has been some trouble with changes around smsc911x
> >> regulator support and Gumstix Overo in particular. Am I just missing the
> >> right regulator in my kernel config or is this a bug? I can test patches
> >> in the latter case.
> > 
> > The second smsc911x now needs a regulator. For multiple smsc911x instances,
> > we should change things around so no regulator is created if one
> > is passed.
> > 
> > Care to test the following patch by passing a fixed regulator
> > from board-overo.c?
> 
> After applying the patch the Ethernet port works consistently once I had
> done a cold boot (reboot from the unpatched kernel did not work).
> Thank you!

Hmm but this patch should not change the behaviour for the first smsc911x
instance unless you specify a custom regulator.. Did you patch in a
custom regulator, or do we have a bug somewhere? Or do you just need to
do a cold reset without the patch I posted?
 
> However, I noticed another problem while testing the patch (not sure if
> it occurs with the previous version, I can check if that helps): A NULL
> pointer dereference occurs when unloading the module, see attached log.

Yes please do check, that needs to be fixed.

Regards,

Tony
