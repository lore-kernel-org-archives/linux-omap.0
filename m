From: Peter Barada <peterb@logicpd.com>
Subject: RE: JTAG debugging of the kernel
Date: Fri, 15 Aug 2008 13:58:16 -0400
Message-ID: <1218823096.24975.108.camel@blackhole>
References: <1218812628.24975.89.camel@blackhole>
	 <0680EC522D0CC943BC586913CF3768C00208C16544@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:52632 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756280AbYHOR6R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Aug 2008 13:58:17 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00208C16544@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2008-08-15 at 23:04 +0530, Syed Mohammed, Khasim wrote:
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter
> > Barada
> > Sent: Friday, August 15, 2008 8:34 PM
> > To: linux-omap@vger.kernel.org
> > Subject: JTAG debugging of the kernel
> > 
> > I've been trying to use JTAG (and an Abatron BDI-2000) to debug the ALSA
> > driver to determine why madplay can't keep up when pulling .mp3 from an
> > SD card, and have not had any luck trying to halt via JTAG and set/stop
> > at breakpoints within the kernelthe kernel.  I've found that JTAG works
> > for a while on kernel startup, but stops working at a non-reproducible
> > point in the startup code.
> > 
> > Have people had success using a BDI-2000 to debug the kernel after it
> > has completed startup?
> > 
> > Any suggestions on what can cause the JTAG to stop working after the
> > kernel starts?
> > 
> 
> I think you should disable Power Management. Which kernel are you using now?

2.6.22.18.  I'm planning to move to 2.6.26 after the dust settles...

I'll try w/o power management, but any idea why power management might
affect JTAG?

> Regards,
> Khasim
