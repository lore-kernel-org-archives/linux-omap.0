From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3 1/8] omap3 flash: rename board-sdp-flash.c to be use
 by other boards
Date: Tue, 6 Jul 2010 11:35:01 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECF359@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
 <20100705122310.GU15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33915 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab0GFGFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 02:05:07 -0400
In-Reply-To: <20100705122310.GU15951@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sukumar,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Monday, July 05, 2010 5:53 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v3 1/8] omap3 flash: rename board-sdp-flash.c to be
> use by other boards
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100616 14:34]:
> > rename board-sdp-flash.c(board-flash.c) and board-sdp.h(board-flash.h)
> to
> > used by other board e.g. zoom
> >
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile                   |    2 +-
> >  arch/arm/mach-omap2/board-3430sdp.c            |   16 ++-
> >  arch/arm/mach-omap2/board-flash.c              |  253
> ++++++++++++++++++++++
> >  arch/arm/mach-omap2/board-sdp-flash.c          |  267 -----------------
> -------
> >  arch/arm/mach-omap2/include/mach/board-flash.h |   28 +++
> >  arch/arm/mach-omap2/include/mach/board-sdp.h   |   21 --
> >  6 files changed, 296 insertions(+), 291 deletions(-)
> >  create mode 100755 arch/arm/mach-omap2/board-flash.c
> >  delete mode 100755 arch/arm/mach-omap2/board-sdp-flash.c
> >  create mode 100644 arch/arm/mach-omap2/include/mach/board-flash.h
> >  delete mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h
> 
> Looks like this one won't apply:
> 
> patching file arch/arm/mach-omap2/board-sdp-flash.c
> Hunk #1 FAILED at 1.
> File arch/arm/mach-omap2/board-sdp-flash.c is not empty after patch, as
> expected
> 
Try "git format-patch -M " when creating renaming patch.

Regards,
Santosh
