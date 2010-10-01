From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: Dropping omap3430 ES1.0 support in mainline
Date: Sat, 2 Oct 2010 03:44:05 +0530
Message-ID: <3700cfbb0159d56cecbda0e06a2957e3@mail.gmail.com>
References: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com> <alpine.DEB.2.00.1010011558290.22941@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47536 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753197Ab0JAWOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 18:14:06 -0400
Received: by mail-ww0-f42.google.com with SMTP id 18so453812wwi.5
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 15:14:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1010011558290.22941@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Paul Walmsley wrote:
> On Sat, 2 Oct 2010, Anand Gadiyar wrote:
>
> > The OMAP3430 ES1.0 was pretty much a test chip, with the  only known
board
> > being the 3430ES1.0 SDP. There are only a small number of these boards
> > outside TI and within TI, they've likely never been used in over 2
years.
> > It's unlikely that these boards still work on mainline, and likely
have
> > been broken in linux-omap since the very beginning.
>
> We had linux-omap booting on the 3430SDP ES1.0 from at least 2007:
>
>
http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/01216
0.html
>
> We've used the 3430SDP ES1.0 as part of our regular testbed up until
last
> year, when it fried itself, so as far as I know, it's worked the whole
> time.
>

Okay, so we're aligned that you guys don't have an ES1 board to test,
and TI doesn't have any either. :)

I'd still like to know if anyone in the wild still cares about the board.

(I see Tony already said "No thanks", but I'd like to know anyway).

- Anand
