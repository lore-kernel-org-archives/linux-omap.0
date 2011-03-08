From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Integration branch base switchover to Tony's omap-for-linus branch
Date: Tue, 8 Mar 2011 20:46:11 +0530
Message-ID: <02124a94c82909eff5a589819ec86357@mail.gmail.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com>
 <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com>
 <4D6F89FB.7080201@ti.com> <4D70F25C.4040206@ti.com> <58ec7480fe87b4d64c33cb2c4454a805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:32981 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755285Ab1CHPQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 10:16:15 -0500
Received: by mail-qy0-f177.google.com with SMTP id 38so4855423qyl.15
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 07:16:13 -0800 (PST)
In-Reply-To: <58ec7480fe87b4d64c33cb2c4454a805@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@ti.com>

Paul,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, March 04, 2011 10:14 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; Benoit Cousson; Paul Walmsley
> Subject: RE: Integration branch base switchover to Tony's omap-for-
> linus branch
>

 [....]

> > Some more debugging by the Hardware team and analyzing
> > the register dumps showed that the I2C_WE register of the i2c
> > modules needs to be programmed correctly for i2c wakeups to
> > function as expected.
> > This turned out to be the root cause for the i2c issues observed
> > by clearing the staticdeps and a patch has been posted
> > to address this...
> > http://marc.info/?l=linux-omap&m=129924557219813&w=2
> >
> > >
> > > Also some more testing showed up a lockup in suspend on OMAP4
> > which I
> > > could narrow down to a similar case with GPT1. Either keeping
> the
> > > staticdep between MPU and L4_WKUP _or_ forcing GPT1 to use
> > software
> > > idle control seems to help.
> >
> > This however is still not rootcaused and is not the same as the
> > issue
> > seen with i2c as the WE for GPT1 is already programmed for
> enabling
> > wakeup.
> >
> > The one way to fix this for now is to put GPT1 block in software
> > controlled idle as was done by your test patch for i2c.
> >
> I tried all the floating patches for static dependency. It did
> worked when CPU RET was tried but with MPU OFF I see the hang.
>
> Below is the global hack I have which works as expected for
> all cases.
>
Thanks to Rajendra for isolating the OMAP4 MPU OFF issue
with static dependency series. The issue is isolated
to MPU <-> EMIF clock dependency.  There issue appears
if we clear this static dependency.

I have posted a patch to work-around this issue till its
being root-caused with help of hardware team so that
OMAP4 PM series continue to work.

'OMAP4: PM: Set static dependency between MPUSS and EMIF'
http://www.listware.net/201103/linux-omap/2628-patch-omap4-pm-set-static-d
ependency-between-mpuss-and-emif.html


Regards,
Santosh
