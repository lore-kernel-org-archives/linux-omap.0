From: "Christensen, Mikkel" <mlc@ti.com>
Subject: RE: [PATCH v2 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
Date: Fri, 15 May 2009 20:28:57 +0200
Message-ID: <E49DAF743FB3E9469ED423C0D3DB5F1CA9646AEA@dnce01.ent.ti.com>
References: <1242409235-18834-1-git-send-email-mlc@ti.com>
	<1242409235-18834-2-git-send-email-mlc@ti.com>
 <87ljoydyyt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35081 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310AbZEOS3E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:29:04 -0400
In-Reply-To: <87ljoydyyt.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi Kevin

On Fri, May 15, 2009 at 13:04:42, Kevin Hilman wrote:
> > ---
> >  arch/arm/mach-omap2/board-zoom2-debugboard.c |  165
> ++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/board-zoom2.c            |  109 
> +++++++++++++++++
> >  2 files changed, 274 insertions(+), 0 deletions(-)  create mode
> > 100644 arch/arm/mach-omap2/board-zoom2-debugboard.c
> >  create mode 100644 arch/arm/mach-omap2/board-zoom2.c
> >
> > diff --git a/arch/arm/mach-omap2/board-zoom2-debugboard.c
> > b/arch/arm/mach-omap2/board-zoom2-debugboard.c
> > new file mode 100644
> > index 0000000..e89b3af
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-zoom2-debugboard.c
> > @@ -0,0 +1,165 @@
> > +/*
> > + * arch/arm/mach-omap2/board-zoom2-debugboard.c
> 
> Can you drop the filename here, and in the other files as well.

Sure I can do the change. Is this a new convention being used? I can see the file name in many other files as well.

/Mikkel

