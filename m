From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: State of SDP4430 platform
Date: Mon, 7 Feb 2011 11:35:00 +0530
Message-ID: <db3a1ff9033b3a83b93c42a2857812e1@mail.gmail.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com> <a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com>
 <ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com> <20110206094919.GA11707@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33330 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854Ab1BGGFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 01:05:03 -0500
Received: by mail-iy0-f180.google.com with SMTP id 42so2828524iyh.25
        for <linux-omap@vger.kernel.org>; Sun, 06 Feb 2011 22:05:02 -0800 (PST)
In-Reply-To: <20110206094919.GA11707@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Sunday, February 06, 2011 3:19 PM
> To: Santosh Shilimkar
> Cc: Paul Walmsley; linux-omap@vger.kernel.org
> Subject: Re: State of SDP4430 platform
>
> On Mon, Jan 17, 2011 at 03:37:34PM +0530, Santosh Shilimkar wrote:
> > The I2C timeout issue I could reproduce on my ES1.0 board. It's
> ES1.0
> > specific issue because I2C burst mode wasn't fuctional on it. Twl
> RTC
> > driver uses I2C burst mode and hence it times out. Other TWL I2C
> > module has no such issue.
> > The pull work-around we tried was not reliable hence it was
> dropped.
> >
> > In short the TWL RTC driver won't function on ES1.0. Apart from
> that
> > rest of the I2C clients should work as usual.
>
> The ES2.2 OMAP4 arrived on Friday.  Fitting it resulted in no change
> to the I2C timeouts:
>
Good that finally the tile reached you. Will have somebody look at
this. Meanwhile, can you send your .config? With the regular
omap2plus defconfig, we didn't see the issue last time.

Regards,
Santosh
