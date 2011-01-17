From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: State of SDP4430 platform
Date: Mon, 17 Jan 2011 15:37:34 +0530
Message-ID: <ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com> <a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38709 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033Ab1AQKHh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 05:07:37 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so6435130fxm.5
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 02:07:36 -0800 (PST)
In-Reply-To: <a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Sunday, January 16, 2011 11:56 AM
> To: Paul Walmsley; Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org
> Subject: RE: State of SDP4430 platform
>
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Sunday, January 16, 2011 11:37 AM
> > To: Russell King - ARM Linux
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: State of SDP4430 platform
> >

[.....]

> > > Other stuff that shows in this boot log:
> >
> > ...
> >
> > > - Bunch of regulators are returning errors (is this a problem?)
> > > - I2C timeouts which add quite a bit to the boot-time
> >
> > These two are probably related.  Looks like something is wrong
> with
> > communication with the TWL/TPS PMIC on that board.  Those problems
> > don't
> > show up on the OMAP4430ES2 Panda here, so they are probably
> > 4430SDP-specific.
> >
> >
> Actually I don't see these errors which ring a bell. There was an
> I2C pull related issue with ES1.0 silicon. I guess these timeouts
> would show up only on ES1.0 OMAP4 boards and not on ES2.0 boards.
>
> Monday I will check on my ES1.0 board and if needed send an updated
> bootloader ( setting up right pull values) or a patch to kernel.
>
The I2C timeout issue I could reproduce on my ES1.0 board. It's ES1.0
specific issue because I2C burst mode wasn't fuctional on it. Twl RTC
driver uses I2C burst mode and hence it times out. Other TWL I2C
module has no such issue.
The pull work-around we tried was not reliable hence it was dropped.

In short the TWL RTC driver won't function on ES1.0. Apart from that
rest of the I2C clients should work as usual.

Regards,
Santosh
