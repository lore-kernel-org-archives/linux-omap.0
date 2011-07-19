From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 1/6] OMAP: move voltage.h and vp.h under platform include directory
Date: Tue, 19 Jul 2011 10:49:33 +0300
Message-ID: <1311061773.10230.18.camel@sokoban>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com> <1311010522-5868-2-git-send-email-t-kristo@ti.com> <20110718181604.GH25081@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36083 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab1GSHtk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 03:49:40 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110718181604.GH25081@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>

On Mon, 2011-07-18 at 20:16 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Jul 18, 2011 at 08:35:17PM +0300, Tero Kristo wrote:
> > This is needed so that these include files can be accessed from drivers.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/voltage.h             |  180 -----------------------------
> >  arch/arm/mach-omap2/vp.h                  |  128 --------------------
> >  arch/arm/plat-omap/include/plat/voltage.h |  179 ++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/vp.h      |  128 ++++++++++++++++++++
> >  4 files changed, 307 insertions(+), 308 deletions(-)
> >  delete mode 100644 arch/arm/mach-omap2/voltage.h
> >  delete mode 100644 arch/arm/mach-omap2/vp.h
> >  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
> >  create mode 100644 arch/arm/plat-omap/include/plat/vp.h
> 
> just one small tip, if you use git format-patch -M, it would detect that
> this was just a rename ;-)
> 

Hmm did not notice this... git-format actually detected that this was a
rename in previous version of the set, even without the -M option. Will
try to remember that in the future.


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

