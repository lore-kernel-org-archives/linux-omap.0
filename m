From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/11] OMAP2+: powerdomain: move header file from plat-omap
 to mach-omap2
Date: Tue, 14 Dec 2010 22:51:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142248130.15971@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061843.30541.23685.stgit@twilight.localdomain> <alpine.DEB.2.00.1012142234340.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55141 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0LOFvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 00:51:19 -0500
In-Reply-To: <alpine.DEB.2.00.1012142234340.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-arm-kernel@lists.infradead.org, Felipe Contreras <felipe.contreras@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <greg@kroah.com>

On Tue, 14 Dec 2010, Paul Walmsley wrote:

> On Tue, 7 Dec 2010, Paul Walmsley wrote:
> 
> > The OMAP powerdomain code and data is all OMAP2+-specific.  This seems
> > unlikely to change any time soon.  Move plat-omap/include/plat/powerdomain.h
> > to mach-omap2/powerdomain.h.  The primary point of doing this is to remove
> > the temptation for unrelated upper-layer code to access powerdomain code
> > and data directly.
> > 
> > As part of this process, remove the references to powerdomain data from
> > the GPIO "driver" and the OMAP PM no-op layer, both in plat-omap.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> 
> This patch has been updated to get DSPBridge building again.  The 
> DSPBridge should not be touching the powerdomain headers;  this is
> just a temporary workaround until the DSPBridge people fix the code.

An old version of this patch was inadvertently sent.  The crucial diff
(for review purposes anyway) from the previous patch is below.
Nothing earthshattering.

The updated integration tag that contains all of these updated changes is
'integration-2.6.38-20101214-013' available from 
git://git.pwsan.com/linux-integration


- Paul

diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/staging/tidspbridge/core/_tiomap.h
index a3190e7..1159a50 100644
--- a/drivers/staging/tidspbridge/core/_tiomap.h
+++ b/drivers/staging/tidspbridge/core/_tiomap.h
@@ -24,7 +24,7 @@
  * be removed.  No driver should call pwrdm_* or clkdm_* functions
  * directly; they should rely on OMAP core code to do this.
  */
-#include <plat/powerdomain.h>
+#include <mach-omap2/powerdomain.h>
 #include <mach-omap2/clockdomain.h>
 /*
  * XXX These mach-omap2/ includes are wrong and should be removed.  No



