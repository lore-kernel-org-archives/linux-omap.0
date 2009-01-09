From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP3 EVM MMC1 support for TPS based PR785 power
	modules
Date: Fri, 9 Jan 2009 14:13:14 +0200
Message-ID: <20090109121310.GM2536@atomide.com>
References: <1229513610-17386-1-git-send-email-mani.pillai@ti.com> <19F8576C6E063C45BE387C64729E739403ECEDD316@dbde02.ent.ti.com> <20090108152659.GS27566@atomide.com> <19F8576C6E063C45BE387C64729E739403ECEDDA84@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55424 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZAIMNO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 07:13:14 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECEDDA84@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Pillai, Manikandan <mani.pillai@ti.com> [090109 05:27]:
> Pls see my responses inline.
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Thursday, January 08, 2009 8:57 PM
> > To: Pillai, Manikandan
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 1/1] OMAP3 EVM MMC1 support for TPS based PR785 power
> > modules

<snip>

> >
> > How about try to figure out a way to share the common code with
> > mmc-twl4030.c?
> [Pillai, Manikandan] Most of the code is derived from mmc-twl4030.c file.
> The intention was to have a different file for mmc-pr785.c. Are you suggesting
> here that I break the mmc-xxxx.c  into 2 files mmc-shared.c and mmc-twl/pr785.c ?

Yeah we could have some shared file for those functions. How about
arch/arm/mach-omap2/hsmmc.c for the shared functions?

Tony
