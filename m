From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks enclosed
 under DEBUG_FS
Date: Mon, 04 Jan 2010 11:42:59 +0200
Message-ID: <1262598179.2381.20.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
	 <1261483154.2108.86.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044A277589@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28573 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0ADJnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 04:43:07 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A277589@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, 2009-12-23 at 17:34 +0100, ext Hiremath, Vaibhav wrote:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Tuesday, December 22, 2009 5:29 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org; linux-fbdev-
> > devel@lists.sourceforge.net; linux-fbdev@vger.kernel.org
> > Subject: Re: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks
> > enclosed under DEBUG_FS
> > 
> > Hi,
> > 
> > On Thu, 2009-12-17 at 16:18 +0100, ext hvaibhav@ti.com wrote:
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > Which warning does this fix? I don't get any compiler warnings.
> > 
> [Hiremath, Vaibhav] Below is the log - 
> 
> 
>   CC      drivers/video/omap2/dss/core.o
> drivers/video/omap2/dss/core.c:129: warning: 'core_dump_clocks' defined but not used
>   CC      drivers/video/omap2/dss/dss.o

Ok. For some reason my compiler doesn't warn about that.

> 
> > Can you change the name of the patch to a more standard one?
> > 
> [Hiremath, Vaibhav] Ok, will do that and resubmit. I believe only prefix "OMAP" should do.

Something like:

OMAP: DSS2: fix compile warning

 Tomi


