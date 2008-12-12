From: Paul Walmsley <paul@pwsan.com>
Subject: Re: status of USB on omap35xx ?
Date: Fri, 12 Dec 2008 13:33:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812121331180.26754@utopia.booyaka.com>
References: <1228870250.32014.148.camel@localhost.localdomain>  <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>  <20081211005733.GZ18138@atomide.com>  <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>  <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
  <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>  <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>  <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>  <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
 <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com> <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40064 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbYLLUdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 15:33:11 -0500
In-Reply-To: <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vikram.pandita@ti.com
Cc: Grazvydas Ignotas <notasas@gmail.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

Hello Vikram,

On Fri, 12 Dec 2008, Grazvydas Ignotas wrote:

> On Fri, Dec 12, 2008 at 1:09 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Fri, 12 Dec 2008, Grazvydas Ignotas wrote:
> 
> >> I'm also getting suspend/resume related problems if I plug a hub
> >> without any devices connected (29sec), and then a device (52sec):
> >
> > If you disable USB autosuspend with no devices connected via
> >
> > echo -1 > /sys/module/usbcore/parameters/autosuspend
> >
> > and then repeat the same test as above, do your devices stay alive?
> Yep, this seems to resolve that issue, I can plug the devices any way
> I want with this. Thanks for showing this.

Were you able to get USB remote wakeup or auto-suspend working on
ehci-omap.c with the 3430SDP?


- Paul
