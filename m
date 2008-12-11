From: Paul Walmsley <paul@pwsan.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 16:09:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com>
References: <1228870250.32014.148.camel@localhost.localdomain>  <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>  <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>  <20081211005733.GZ18138@atomide.com>
 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>  <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>  <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>  <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
 <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com> <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49056 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757861AbYLKXJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 18:09:07 -0500
In-Reply-To: <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

Hello Grazvydas,

On Fri, 12 Dec 2008, Grazvydas Ignotas wrote:

> On Thu, Dec 11, 2008 at 11:07 PM, Paul Walmsley <paul@booyaka.com> wrote:
> > Gravyzdas, can you send us a commit ID that results in successful device
> > enumeration (after reverting
> > http://marc.info/?l=linux-omap&m=122453174024860&w=2 ?)  Sounds like it
> > was working for you in late October with that revert.
> 
> There is no need to - EHCI works (almost) fine on pandora with current HEAD.

Might you be willing to try a build with the first two patches
from this series posted earlier today with the subject:

[PATCH 0/3 NOT FOR MERGING] ehci-omap clock rewrite test patches

and see if things still almost work?  If so, then we can get the nasty
direct CM writes out of that driver.

> I'm also getting suspend/resume related problems if I plug a hub
> without any devices connected (29sec), and then a device (52sec):

If you disable USB autosuspend with no devices connected via

echo -1 > /sys/module/usbcore/parameters/autosuspend

and then repeat the same test as above, do your devices stay alive?


- Paul
