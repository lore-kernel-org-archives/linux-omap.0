From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Errors when building for omap4 only
Date: Thu, 6 Jan 2011 19:32:09 +0530
Message-ID: <23f6ffb3d1a6ddd06de44cd77764c680@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302482019D4@dbde02.ent.ti.com>
 <568127b70200733a61aa8c358fb49292@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB5930248201A31@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37360 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599Ab1AFOCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 09:02:15 -0500
Received: by yxl31 with SMTP id 31so7217695yxl.14
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 06:02:14 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930248201A31@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev [mailto:premi@ti.com]
> Sent: Thursday, January 06, 2011 7:26 PM
> To: Shilimkar, Santosh; linux-omap Mailing List
> Subject: RE: Errors when building for omap4 only
>
>
>
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Thursday, January 06, 2011 7:19 PM
> > To: Premi, Sanjeev; linux-omap Mailing List
> > Subject: RE: Errors when building for omap4 only
> >
> > Sanjeev,
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> > > Sent: Thursday, January 06, 2011 6:18 PM
> > > To: linux-omap Mailing List
> > > Subject: Errors when building for omap4 only
> > >
> > > Hi all,
> > >
> > > I was trying to build OMAP4 only kernel from the linux-omap
> master.
> > > Came across few failures caused by exclusion of OMAP3/3 specific
> > > code via #ifdef.
> > >
> > These are addressed already. You could look at below series
> > http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg41712.html
> >
>
> Great! I missed the series.
>
> Question (after quick browse): Don't addition stubs add too many
> strings to the code?
>
They do. But we want these functions to throw warning when they are
used on wrong SOCS. So that wrong usage is avoided and if exist can
be killed.
