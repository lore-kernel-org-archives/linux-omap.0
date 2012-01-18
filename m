From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP3 DSS2 - VENC timings
Date: Wed, 18 Jan 2012 07:59:02 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A950E@DBDE01.ent.ti.com>
References: <4F1467B5.80600@mlbassoc.com> <1326872303.1954.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41099 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755950Ab2ARH7J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jan 2012 02:59:09 -0500
In-Reply-To: <1326872303.1954.28.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jan 18, 2012 at 13:08:23, Valkeinen, Tomi wrote:
> On Mon, 2012-01-16 at 11:08 -0700, Gary Thomas wrote:
> > I'm running a frame buffer console on a TV device via the VENC.
> > The video timings don't see to be quite right as Tux is about
> > 1/2 off the screen - both directions, i.e. his head and right
> > side have been cut off as they are outside the viewable area.
> > Also, when I send data to the device (via /dev/tty1) which has
> > 90x35 characters, I lose 4 characters on each end of every line.
> > 

I am not sure whether this applies here with your issue, but if I remember
correctly, during initial days of development we had similar issue where, corners of the display cuts-off. The conclusion was, analog TV's crops the ~5-10% of the input image (depends on TV). I don't quite remember further details on this...


Thanks,
Vaibhav

> > Is there something I can do about this?  I've looked at the
> > timings in drivers/video/omap2/dss/venc.c
> 
> I don't know much about analog TV, but my understanding is that there's
> always overscanning going on. You just have to size and position the
> overlay so that it is visible on your TV.
> 
> > Also, how can I select NTSC vs PAL setups via the command line?
> > I have only the one video device VENC.
> 
> Documentation/arm/OMAP/DSS says you can echo "pal" or "ntsc" to
> sys/devices/platform/omapdss/display?/timings file.
> 
>  Tomi
> 
> 

