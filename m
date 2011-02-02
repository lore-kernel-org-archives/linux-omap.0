From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: handling clock nodes with both parent and divider selection
Date: Wed, 2 Feb 2011 09:38:21 +0530
Message-ID: <d1eefcbf311a0a741569c792c860d227@mail.gmail.com>
References: <045d24bba9bbbe9fa47f0f8aa9901b7e@mail.gmail.com>
 <alpine.DEB.2.00.1101311610060.16671@utopia.booyaka.com> <a42717ae46ffbd2f8b30cca9ad559d93@mail.gmail.com>
 <alpine.DEB.2.00.1102010931530.16671@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:55389 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295Ab1BBEI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 23:08:26 -0500
Received: by fxm19 with SMTP id 19so7868687fxm.8
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 20:08:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102010931530.16671@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 01, 2011 10:03 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: RE: handling clock nodes with both parent and divider selection
>
> On Tue, 1 Feb 2011, Rajendra Nayak wrote:
>
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Tuesday, February 01, 2011 4:43 AM
> >
> > > At some point in the future, hopefully we'll be able to split all of
the
> > > multiplexers and dividers into their own struct clks, or struct
> > omap_clks,
> > > or something, so we don't have to implement these hacks.  As I
> > understand
> > > it, that would be closer to the actual hardware, anyway.  The right
time
> > > to do that would be after the clktype conversion...
> >
> > Ok, I am not completely sure what clktype conversion means, but will
> > wait for it.
>
> I'd suggest not waiting for it, but implementing something now, similar
to
> OMAP3, if it won't be too big of a hack.

Yup, I will. I just meant to say will wait for your patches to see what
clktype conversion meant, since I did not know of it.
Did not mean to say will wait for it to add the divider control
for aux clks :)

>
>
> - Paul
