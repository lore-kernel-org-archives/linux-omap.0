From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Mon, 8 Dec 2008 19:37:05 -0200
Message-ID: <20081208193705.13a70fa2@pedra.chehab.org>
References: <5d5443650812022248p28f42ce4n513dceb18adadeab@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739403E90E6E06@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:46173 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYLHVhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 16:37:16 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E6E06@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

On Wed, 3 Dec 2008 12:35:08 +0530
"Hiremath, Vaibhav" <hvaibhav@ti.com> wrote:

> I can tell you that for OMAP3 we do have lot of files coming in, and it really brings more confusion if we have OMAP1 and OMAP2 lying outside and OMAP3 code (Display + capture) say under omap/ or omap3/.
> 
> It makes sense to have omap/ directory, and all the versions/devices of OMAP get handled from omap/Kconfig and omap/Makefile. Even if they have single file it would be nice to follow directory layers.
> 
> Hans, Sakari or Mauro can provide their opinion on this, and decide how to handle this. 
> 
> I am just providing details, so that it would be easy to take decision - 
> 
> OMAP1 - (I have listed names from old O-L tree)
> 	- omap16xxcam.c
> 	- camera_core.c
> 	- camera_hw_if.h
> 	- omap16xxcam.h
> 	- camera_core.h
> 
> OMAP2 - (I have listed names from old O-L tree)
> 	- omap24xxcam.c
> 	- omap24xxcam-dma.c
> 	- omap24xxcam.h
> 
> In future may be display will add here.
> 
> OMAP3 - 
> 	Display - (Posted twice with old DSS library)
> 		- omap_vout.c
> 		- omap_voutlib.c
> 		- omap_voutlib.h
> 		- omap_voutdef.h
> 	Camera - (Will come soon)
> 		- omap34xxcam.c
> 		- omap34xxcam.h
> 	ISP - (Will come soon)
> 		- Here definitely we will plenty number of files.

I prefer to have a separate directory for omap drivers. This helps to confine Kconfig/Makefile changes internally to the driver sub-dir, avoiding merge conflicts with other drivers.

Also, it helps to better organize the files.

By listening to Trilok arguments that this would be converted into just two
files for each omap version in the long run, Maybe we can just add all thee
drivers into /omap.

Cheers,
Mauro
