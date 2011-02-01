From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: handling clock nodes with both parent and divider selection
Date: Tue, 1 Feb 2011 16:58:15 +0530
Message-ID: <a42717ae46ffbd2f8b30cca9ad559d93@mail.gmail.com>
References: <045d24bba9bbbe9fa47f0f8aa9901b7e@mail.gmail.com> <alpine.DEB.2.00.1101311610060.16671@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48545 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750951Ab1BAL2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 06:28:19 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so6902933fxm.29
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 03:28:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101311610060.16671@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 01, 2011 4:43 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: handling clock nodes with both parent and divider selection
>
> On Mon, 31 Jan 2011, Rajendra Nayak wrote:
>
> > Hi Paul,
> >
> > On OMAP4, some aux clk nodes (part of SCRM) have control
> > for both parent and divider selection. Is there a way in the
> > current clock framework for OMAP's to handle this?
>
> For these clocks on OMAP3, we split the clock into two struct clks.  For
> example, clkout2_src_ck handles source selection, and sys_clkout2
handles
> rate selection.  clock3xxx_data.c has the details.

Ok, that's pretty much how I was thinking of handling it too. Did'nt know
this is already done for a few nodes on OMAP3.
The only downside of this approach, I feel, is that the users of these
clks
(aux clks on omap4) would have to deal with 2 different nodes, one for
source selection and another for divider.

>
> At some point in the future, hopefully we'll be able to split all of the
> multiplexers and dividers into their own struct clks, or struct
omap_clks,
> or something, so we don't have to implement these hacks.  As I
understand
> it, that would be closer to the actual hardware, anyway.  The right time
> to do that would be after the clktype conversion...

Ok, I am not completely sure what clktype conversion means, but will wait
for
it.

Regards,
Rajendra

>
>
> - Paul
