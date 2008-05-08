From: Tony Lindgren <tony@atomide.com>
Subject: Re: TWL4030 intermittent freakout on boot
Date: Thu, 8 May 2008 11:28:08 -0700
Message-ID: <20080508182807.GE24454@atomide.com>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com> <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65224 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbYEHS2L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 14:28:11 -0400
Content-Disposition: inline
In-Reply-To: <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, peter.de-schrijver@nokia.com, Beagle Board <beagleboard@googlegroups.com>

* Koen Kooi <k.kooi@student.utwente.nl> [080508 11:22]:
> 
> Op 8 mei 2008, om 20:13 heeft Paul Walmsley het volgende geschreven:
> >
> > Hello everyone,
> >
> > occasionally the TWL4030 driver on the 3430SDP freaks out on boot.   
> > (This
> > is either an ES2.0 or ES2.1, not sure.)  Here's a partial console  
> > log with
> > initcall debugging enabled.  This probably happens every thirty or  
> > forty
> > boots, I would guess.  The board does boot to userspace when this  
> > happens.
> >
> > Perhaps the TWL4030 experts out there might know what's going on?
> >
> > <3>i2c_omap i2c_omap.1: controller timed out
> > <3>i2c_omap i2c_omap.1: controller timed out
> > <3>twl4030_usb: i2c write failed, line 422
> 
> Looks suspiciously like the symptons in
> 
> http://code.google.com/p/beagleboard/issues/detail?id=14

This also looks similar to the earlier twl4030 hangs where access
to some domains caused twl4030 to hang. If twl4030 hangs, there's
no way to reset it as all control is over I2C. When twl4030 hangs,
bootloader won't be able to detect the chip either unless devices
is power cycled (and USB cable detached).

The reason earlier was that twl4030 internal clock was not being
programmed properly, and was fixed by patch
0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d.

Maybe there's some twl4030 register access going on before the
internal clock is programmed properly?

Tony
