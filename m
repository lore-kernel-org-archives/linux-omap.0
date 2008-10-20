From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAPFB: fix printing of reserved memory
Date: Mon, 20 Oct 2008 17:45:18 +0300
Message-ID: <1224513918.23383.14.camel@tubuntu>
References: <20080912102716.23245.73291.stgit@tubuntu>
	 <20081017214530.GD18573@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43215 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYJTOpe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 10:45:34 -0400
In-Reply-To: <20081017214530.GD18573@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2008-10-17 at 14:45 -0700, ext Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [080912 03:27]:
> > Print reserved memory only if it was actually reserved.
> 
> Can you reply with your Signed-off-by?

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

> 
> Thanks,
> 
> Tony
> 
> > ---
> > 
> >  arch/arm/plat-omap/fb.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
> > index f9927a7..63c82ef 100644
> > --- a/arch/arm/plat-omap/fb.c
> > +++ b/arch/arm/plat-omap/fb.c
> > @@ -207,9 +207,10 @@ void __init omapfb_reserve_sdram(void)
> >  			config_invalid = 1;
> >  			return;
> >  		}
> > -		if (rg.paddr)
> > +		if (rg.paddr) {
> >  			reserve_bootmem(rg.paddr, rg.size, BOOTMEM_DEFAULT);
> > -		reserved += rg.size;
> > +			reserved += rg.size;
> > +		}
> >  		omapfb_config.mem_desc.region[i] = rg;
> >  		configured_regions++;
> >  	}
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

