From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot failure)
Date: Thu, 3 Feb 2011 14:13:19 +0530
Message-ID: <cace62268ad657586f07ecbb0e6a99ab@mail.gmail.com>
References: <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com>
 <20110106203238.GH1198@n2100.arm.linux.org.uk> <20110106204053.GA7771@atomide.com>
 <20110107161230.GR1198@n2100.arm.linux.org.uk> <20110110185209.GC4957@atomide.com>
 <20110111231611.GX4957@atomide.com> <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
 <20110202011006.GP3358@atomide.com> <81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com>
 <20110202194855.GA3322@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:51043 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755360Ab1BCInW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 03:43:22 -0500
Received: by mail-gx0-f173.google.com with SMTP id 28so412990gxk.32
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 00:43:22 -0800 (PST)
In-Reply-To: <20110202194855.GA3322@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, February 03, 2011 1:19 AM
> To: Santosh Shilimkar
> Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> kernel@lists.infradead.org; linux-omap@vger.kernel.org; Keshava
> Munegowda; Felipe Balbi
> Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> 4430SDP boot failure)
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110201 22:04]:
> > >
> > > It's a ES1.0 blaze, with the patch below it reboots early
> > > during the boot. I also have to disable omap_l2_cache_init
> > > on this board to get it to boot.
> > >
> > Do you still get this problem with 'omap_l2_cache_init' ?
> > As reported earlier, we don't see this issue on ES1.0
> > SDP.
>
> Yeah I do, it rarely makes it to the userspace. Works reliably
> if I disable omap_l2_cache_init.
>
Ok. I shall try few experiments and try to reproduce it
