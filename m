From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 2/2] OMAP: add omap_device_reset()
Date: Mon, 30 May 2011 08:55:47 +0300
Message-ID: <1306734947.2117.9.camel@deskari>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
	 <1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>
	 <4DDF9B5D.7060408@ti.com> <1306500367.1905.18.camel@deskari>
	 <alpine.DEB.2.00.1105292022080.8973@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49973 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181Ab1E3Fzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 01:55:52 -0400
Received: by mail-ew0-f43.google.com with SMTP id 20so2155623ewy.30
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 22:55:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1105292022080.8973@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, 2011-05-29 at 20:24 -0600, Paul Walmsley wrote:
> Hi Tomi,
> 
> On Fri, 27 May 2011, Tomi Valkeinen wrote:
> 
> > DSS driver has been designed so that it resets the HW before it begins
> > programming it. That way we get the HW into known state. Otherwise we
> > need to be extra careful to program all possible registers to a sane
> > value. Not impossible, of course, but requires extra work.
> > 
> > I noticed the problem with DSI driver, it didn't work anymore if I
> > didn't reset it.
> 
> One thing that I don't quite understand about this thread is that the 
> hwmod code should be resetting the DSS hwmods when the system boots.  Is 
> something not working with this process?

I believe that is working fine.

The problem appears when DSS is turned off (i.e. the screen is blanked)
and then started again. The driver has been written so that it will
reset the DSS HW before starting to use that particular DSS HW block, to
get a clean state. Remove that reset, and we've got all the old register
values lying around, causing the device to malfunction.

This should be fixable in the driver, of course, although my experience
with DSI (and DSS in general) shows that it's not always very easy to
stop and restart the HW without a reset.

However, I'd still argue that a driver is more robust if it does do a
reset when starting up the HW. Perhaps the driver should be developed
without that reset, but in the production device the reset should give
us extra protection for unexpected situations.

> That is a separate case from the error recovery case.  Sounds like we may 
> need to expose a reset function for that purpose as well.  Tomi, I don't 
> think your proposed patch is enough for this, though: we'd also need to 
> reset the hwmod internal state for that module, and reprogram the 
> SYSCONFIG bits, etc. as mach-omap2/omap_hwmod.c:_setup() does.

Ah, ok, sounds right. It worked for me, but I probably wouldn't notice
if the PM bits in SYSCONFIG are wrong, as I didn't do any PM testing.

 Tomi


