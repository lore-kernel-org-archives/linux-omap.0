From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Thu, 4 Dec 2008 15:45:35 -0800
Message-ID: <20081204234534.GJ7054@atomide.com>
References: <C8A6D84C-B0DE-4169-B9B0-744285908E42@student.utwente.nl> <19F8576C6E063C45BE387C64729E739403E90E6EBA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63103 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYLDXpn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 18:45:43 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E6EBA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, Trilok Soni <soni.trilok@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [081203 01:38]:
> 
> 
> Thanks,
> Vaibhav Hiremath
> 
> > -----Original Message-----
> > From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> > Sent: Wednesday, December 03, 2008 3:04 PM
> > To: Hiremath, Vaibhav
> > Cc: Trilok Soni; Hans Verkuil; Sakari Ailus; linux-
> > omap@vger.kernel.org Mailing List; video4linux-list@redhat.com
> > Subject: Re: [PATCH] Add OMAP2 camera driver
> > 
> > 
> > Op 3 dec 2008, om 08:05 heeft Hiremath, Vaibhav het volgende
> > geschreven:
> > > OMAP3 -
> > > 	Display - (Posted twice with old DSS library)
> > > 		- omap_vout.c
> > > 		- omap_voutlib.c
> > > 		- omap_voutlib.h
> > > 		- omap_voutdef.h
> > > 	Camera - (Will come soon)
> > > 		- omap34xxcam.c
> > > 		- omap34xxcam.h
> > > 	ISP - (Will come soon)
> > > 		- Here definitely we will plenty number of files.
> > 
> > Isn't DSS2 supposed to work on omap2 (and perhaps omap1) as well?
> > 
> [Hiremath, Vaibhav] yes, but the DSS2 library goes under arch/arm/plat-omap/dss/. The above files are belongs to the driver underneath.

Huh? Why would it need to be under plat-omap?

Tony
