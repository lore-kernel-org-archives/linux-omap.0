From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Patch to fix swapping of front and back porches when reading
 from modedb.c
Date: Thu, 09 Sep 2010 11:28:11 +0300
Message-ID: <1284020891.13006.12.camel@tubuntu.research.nokia.com>
References: <4C87920F.9050005@gmail.com>
	 <AANLkTikkrkVMv0gwx6f8TRGEV8A8yCS1QRg1p7izfadF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:59356 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0III2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 04:28:14 -0400
In-Reply-To: <AANLkTikkrkVMv0gwx6f8TRGEV8A8yCS1QRg1p7izfadF@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russ Dill <russ.dill@gmail.com>, Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-09-08 at 15:38 +0200, ext Russ Dill wrote:
> On Wed, Sep 8, 2010 at 6:39 AM, Tasslehoff Kjappfot <tasskjapp@gmail.com> wrote:
> >
> >
> > Hi list :-)
> >
> > I had trouble getting a standard 800x600@60Hz VGA signal to display
> > correctly on my monitors. Measuring the output showed that the front and
> > back porches were swapped both for hsync and vsync. After reading the source
> > I think I found the error in drivers/video/omap2/omapfb/omapfb-main.c. Patch
> > attached.
> >
> > http://www.xfree86.org/3.3.6/fbdev6.html shows the way it should be, but
> > todays code sets:
> >
> > hfp = left margin
> > hbp = right margin
> > vfp = upper margin
> > vbp = lower margin
> >
> > I tested a patched kernel with 800x600@60Hz on two different monitors and a
> > vga grabber, and it solved my issues.
> 
> This looks good. Before this came up, I also thought that front porch
> meant left margin, and back porch meant margin, but margins are named
> in relation to pixel data, and porches are named in relation to sync
> pulses.

Ah, that's new to me too =). After a few minutes of googling, it's quite
clear that the patch is correct.

Thanks! I improved the patch description a bit, and added it to my tree.

 Tomi


