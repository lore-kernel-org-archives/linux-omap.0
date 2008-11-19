From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [Linux-fbdev-devel] [PATCHv3 1/4] OMAP 2/3 DSS Library
Date: Wed, 19 Nov 2008 09:36:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E8E6762A@dbde02.ent.ti.com>
References: <20081118181057.GA15652@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44116 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYKSEHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 23:07:45 -0500
In-Reply-To: <20081118181057.GA15652@fluff.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, "Shah, Hardik" <hardik.shah@ti.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Ben Dooks [mailto:ben-linux@fluff.org]
> Sent: Tuesday, November 18, 2008 11:41 PM
> To: Shah, Hardik
> Cc: video4linux-list@redhat.com; linux-omap@vger.kernel.org; linux-
> fbdev-devel@lists.sourceforge.net
> Subject: Re: [Linux-fbdev-devel] [PATCHv3 1/4] OMAP 2/3 DSS Library
> 
> On Tue, Nov 04, 2008 at 02:49:17PM +0530, Hardik Shah wrote:
> > Removed the io_p2v macro and used ioremap and
> > __raw_readl/__raw_writel instead.
> >
> > Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
> >  		Hari Nagalla <hnagalla@ti.com>
> >  		Hardik Shah <hardik.shah@ti.com>
> >  		Manjunath Hadli <mrh@ti.com>
> >  		R Sivaraj <sivaraj@ti.com>
> >  		Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > ---
> >  arch/arm/plat-omap/Kconfig                 |    7 +
> >  arch/arm/plat-omap/Makefile                |    2 +-
> >  arch/arm/plat-omap/include/mach/omap-dss.h |  896 +++++++++++
> >  arch/arm/plat-omap/omap-dss.c              | 2268
> ++++++++++++++++++++++++++++
> 
> why is this huge driver under arch/arm/plat-omap?
> 
[Hiremath, Vaibhav] omap-dss.c is the OMAP-DSS library which will export low level API's to upper level driver (V4L2 and FBDEV). For more information please refer to the RFC which we had posted some time back, below is the link

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02510.html


Again this is the old story on OMAP3-DSS development, there was parallel development from Nokia and we had acknowledged their design and implementation and started working/developing on top of it.

> >  4 files changed, 3172 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/plat-omap/include/mach/omap-dss.h
> >  create mode 100644 arch/arm/plat-omap/omap-dss.c
