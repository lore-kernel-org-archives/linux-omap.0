From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] ARM: OMAP: igep0020: use display init from
 dss-common
Date: Wed, 9 Oct 2013 07:58:09 -0700
Message-ID: <20131009145809.GY8313@atomide.com>
References: <1381310359-20668-1-git-send-email-javier.martinez@collabora.co.uk>
 <1381310359-20668-3-git-send-email-javier.martinez@collabora.co.uk>
 <52552171.6050002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45537 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754128Ab3JIO6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 10:58:15 -0400
Content-Disposition: inline
In-Reply-To: <52552171.6050002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131009 02:35]:
> On 09/10/13 12:19, Javier Martinez Canillas wrote:
> > Now that display information and setup is made from dss-common
> > there is no need to have this code in the board file.
> > 
> > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > ---
> > 
> > Changes since v2:
> >  - None, this is a new patch added for v3.
> > 
> >  arch/arm/mach-omap2/board-igep0020.c | 41 +++---------------------------------
> >  1 file changed, 3 insertions(+), 38 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> > index 06dbb2d..d648d50 100644
> > --- a/arch/arm/mach-omap2/board-igep0020.c
> > +++ b/arch/arm/mach-omap2/board-igep0020.c
> > @@ -43,6 +43,7 @@
> >  #include "board-flash.h"
> >  #include "control.h"
> >  #include "gpmc-onenand.h"
> > +#include "dss-common.h"
> 
> I didn't try, but I think these can be now removed from the board file:
> 
> #include <video/omapdss.h>
> #include <video/omap-panel-data.h>
> 
> For the series:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Applying these instead of the earlier versions into
omap-for-v3.13/quirk branch.

Regards,

Tony
