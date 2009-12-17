From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/2] omap3: cm-t35: enable display subsystem
Date: Thu, 17 Dec 2009 11:15:30 +0200
Message-ID: <1261041330.26016.57.camel@tubuntu.research.nokia.com>
References: <cover.1260777313.git.mike@compulab.co.il>
	 <4B29E76F.6060709@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63862 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbZLQJPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 04:15:46 -0500
In-Reply-To: <4B29E76F.6060709@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Rapoport <mike@compulab.co.il>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-12-17 at 09:10 +0100, ext Mike Rapoport wrote:
> Hi Tomi,
> Any updates on this?

Looks fine to me, I'll take it to my queue. 

 Tomi

> 
> Mike Rapoport wrote:
> > The below patches add display support for CM-T35 board.
> > 
> > The following changes since commit f40542532e96dda5506eb76badea322f2ae4731c:
> >   Linus Torvalds (1):
> >         Merge branch 'ixp4xx' of git://git.kernel.org/.../chris/linux-2.6
> > 
> > Mike Rapoport (2):
> >   OMAP: DSS2: add Toppoly TDO35S panel
> >   omap3: cm-t35: add DSS2 display support
> > 
> >  arch/arm/mach-omap2/board-cm-t35.c                 |  239 +++++++++++++++++++-
> >  drivers/video/omap2/displays/Kconfig               |    6 +
> >  drivers/video/omap2/displays/Makefile              |    1 +
> >  .../video/omap2/displays/panel-toppoly-tdo35s.c    |  112 +++++++++
> >  4 files changed, 357 insertions(+), 1 deletions(-)
> >  create mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> > 
> > 
> 


