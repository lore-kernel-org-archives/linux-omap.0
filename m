From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/6] OMAPDSS: remove unnecessary plat/clock.h includes
Date: Fri, 28 Sep 2012 06:28:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209280628140.2027@utopia.booyaka.com>
References: <20120927162800.21755.62891.stgit@dusk.lan>  <20120927163329.21755.34776.stgit@dusk.lan> <1348813466.2437.1.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47891 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2I1G2f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Sep 2012 02:28:35 -0400
In-Reply-To: <1348813466.2437.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

On Fri, 28 Sep 2012, Tomi Valkeinen wrote:

> On Thu, 2012-09-27 at 10:33 -0600, Paul Walmsley wrote:
> > The OMAP DSS video drivers include <plat/clock.h> but don't use any
> > information from that file.  These includes are causing problems with
> > ARM single image kernels - remove them.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  drivers/video/omap2/dss/dispc.c |    1 -
> >  drivers/video/omap2/dss/dsi.c   |    1 -
> >  drivers/video/omap2/dss/dss.c   |    1 -
> >  3 files changed, 3 deletions(-)
> 
> Hi Paul. I already have the below patch in omapdss branch, and it's also
> in linux-next.

thanks, will drop this one.


- Paul
