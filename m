From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Fri, 5 Dec 2008 11:12:59 -0800
Message-ID: <20081205191258.GH9714@atomide.com>
References: <20081204234534.GJ7054@atomide.com> <19F8576C6E063C45BE387C64729E739403E90E75B9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57061 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbYLETNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 14:13:08 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E75B9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, Trilok Soni <soni.trilok@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [081205 10:58]:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > * Hiremath, Vaibhav <hvaibhav@ti.com> [081203 01:38]:

<snip>

> > > > Isn't DSS2 supposed to work on omap2 (and perhaps omap1) as
> > well?
> > > >
> > > [Hiremath, Vaibhav] yes, but the DSS2 library goes under
> > arch/arm/plat-omap/dss/. The above files are belongs to the driver
> > underneath.
> > 
> > Huh? Why would it need to be under plat-omap?
> > 
> [Hiremath, Vaibhav] This is low level library which will export
> Kernel API's to top level driver like, Frame buffer and V4L2 driver.
> So this has to be in some common directory, and both patches on
> DSS (from Tomi and from TI) aligned to the same thing.

We're not adding driver specific code to arch/arm/plat-omap.

Please place your shared driver code either under drivers/video
and export the functions needed by v4l like all other linux
driver code does.

Regards,

Tony

