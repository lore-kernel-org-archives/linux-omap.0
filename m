From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] Add OMAP2 camera driver
Date: Sat, 6 Dec 2008 00:27:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E90E75B9@dbde02.ent.ti.com>
References: <20081204234534.GJ7054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42819 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbYLES7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 13:59:08 -0500
In-Reply-To: <20081204234534.GJ7054@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, Trilok Soni <soni.trilok@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, December 05, 2008 5:16 AM
> To: Hiremath, Vaibhav
> Cc: Koen Kooi; Trilok Soni; Hans Verkuil; Sakari Ailus; linux-
> omap@vger.kernel.org Mailing List; video4linux-list@redhat.com
> Subject: Re: [PATCH] Add OMAP2 camera driver
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [081203 01:38]:
> >
> >
> > Thanks,
> > Vaibhav Hiremath
> >
> > > -----Original Message-----
> > > From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> > > Sent: Wednesday, December 03, 2008 3:04 PM
> > > To: Hiremath, Vaibhav
> > > Cc: Trilok Soni; Hans Verkuil; Sakari Ailus; linux-
> > > omap@vger.kernel.org Mailing List; video4linux-list@redhat.com
> > > Subject: Re: [PATCH] Add OMAP2 camera driver
> > >
> > >
> > > Op 3 dec 2008, om 08:05 heeft Hiremath, Vaibhav het volgende
> > > geschreven:
> > > > OMAP3 -
> > > > 	Display - (Posted twice with old DSS library)
> > > > 		- omap_vout.c
> > > > 		- omap_voutlib.c
> > > > 		- omap_voutlib.h
> > > > 		- omap_voutdef.h
> > > > 	Camera - (Will come soon)
> > > > 		- omap34xxcam.c
> > > > 		- omap34xxcam.h
> > > > 	ISP - (Will come soon)
> > > > 		- Here definitely we will plenty number of files.
> > >
> > > Isn't DSS2 supposed to work on omap2 (and perhaps omap1) as
> well?
> > >
> > [Hiremath, Vaibhav] yes, but the DSS2 library goes under
> arch/arm/plat-omap/dss/. The above files are belongs to the driver
> underneath.
> 
> Huh? Why would it need to be under plat-omap?
> 
[Hiremath, Vaibhav] This is low level library which will export Kernel API's to top level driver like, Frame buffer and V4L2 driver. So this has to be in some common directory, and both patches on DSS (from Tomi and from TI) aligned to the same thing.

> Tony

