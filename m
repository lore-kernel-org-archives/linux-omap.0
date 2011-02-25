From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot failure)
Date: Fri, 25 Feb 2011 11:03:48 +0530
Message-ID: <08df39a319ecf8f67fb87b4ba3af85dd@mail.gmail.com>
References: <20110106204053.GA7771@atomide.com> <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com>
 <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com> <20110202011006.GP3358@atomide.com>
 <81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com> <20110202194855.GA3322@atomide.com>
 <cace62268ad657586f07ecbb0e6a99ab@mail.gmail.com> <84fafb82318b1287513d198c6535eb59@mail.gmail.com>
 <20110224173840.GC20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54699 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276Ab1BYFdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 00:33:51 -0500
Received: by mail-qy0-f182.google.com with SMTP id 27so1162529qyk.20
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 21:33:50 -0800 (PST)
In-Reply-To: <20110224173840.GC20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, February 24, 2011 11:09 PM
> To: Santosh Shilimkar
> Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> kernel@lists.infradead.org; linux-omap@vger.kernel.org; Keshava
> Munegowda; Felipe Balbi
> Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> 4430SDP boot failure)
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110212 00:45]:
> > Tony,
> > > -----Original Message-----
> > > From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> > > Sent: Thursday, February 03, 2011 2:13 PM
> > > To: Tony Lindgren
> > > Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> > > kernel@lists.infradead.org; linux-omap@vger.kernel.org; Keshava
> > > Munegowda; Felipe Balbi
> > > Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> > > 4430SDP boot failure)
> > >
> > > > -----Original Message-----
> > > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > > Sent: Thursday, February 03, 2011 1:19 AM
> > > > To: Santosh Shilimkar
> > > > Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> > > > kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> Keshava
> > > > Munegowda; Felipe Balbi
> > > > Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP
> (Re:
> > > > 4430SDP boot failure)
> > > >
> > > > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110201 22:04]:
> > > > > >
> > > > > > It's a ES1.0 blaze, with the patch below it reboots early
> > > > > > during the boot. I also have to disable omap_l2_cache_init
> > > > > > on this board to get it to boot.
> > > > > >
> > > > > Do you still get this problem with 'omap_l2_cache_init' ?
> > > > > As reported earlier, we don't see this issue on ES1.0
> > > > > SDP.
> > > >
> > > > Yeah I do, it rarely makes it to the userspace. Works reliably
> > > > if I disable omap_l2_cache_init.
> > > >
> > > Ok. I shall try few experiments and try to reproduce it
> >
> > Not sure if it's the same issue but I managed to reproduce the
> > issue on ES2.0 itself. And after some experiments, it boiled
> > down to the V6 and V7 issue. By disabling OMAP2 from the build,
> > everything was fine again.
>
> Was this with linux-omap master branch or mainline?
>
> The V6 vs V7 issues should be sorted out with Russell's patches that
> we also have now in linux-omap master branch.
>
This was with mainline.
Then I applied RMK's series and things were OK.
