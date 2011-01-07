From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure
Date: Fri, 7 Jan 2011 17:54:44 +0530
Message-ID: <53f93de082e315abea017da88aeba994@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com>
 <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk>
 <20110106235203.GA14425@n2100.arm.linux.org.uk> <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com>
 <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com>
 <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58900 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803Ab1AGMYp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 07:24:45 -0500
Received: by mail-fx0-f52.google.com with SMTP id 5so16142084fxm.11
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:24:44 -0800 (PST)
In-Reply-To: <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Sorry,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, January 07, 2011 5:49 PM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: RE: 4430SDP boot failure
>
> > -----Original Message-----
> > From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> > Sent: Friday, January 07, 2011 3:23 PM
> Ruessell,
>
>
> > To: Russell King - ARM Linux
> > Cc: linux-omap@vger.kernel.org; Tony Lindgren
> > Subject: RE: 4430SDP boot failure
> >
>
> [....]
>
> > > BTW, if it makes any difference to the boot loader, please note
> > that
> > > I'm
> > > still waiting for the upgrade for the SDP board.
> > That means your board is with ES1.0. I shall try 2.6.37 on
> > ES1.0
>
> ES1.0 boot nicely on 2.6.37 and I guess I know why you are seeing an
> issue. The console is changed to OMAP serial driver from 8250
> driver.
>
> Can you try "console=ttyO2" instead of existing ""console=ttyS2" ??
>
Ignore my last email. You have tried that already
Will send you updated boot-loaders in next few mins.
