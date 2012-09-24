From: Tony Lindgren <tony@atomide.com>
Subject: Re: tidspbridge build fails
Date: Mon, 24 Sep 2012 10:00:54 -0700
Message-ID: <20120924170054.GE28835@atomide.com>
References: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com>
 <loom.20120924T183345-467@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:30533 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751417Ab2IXRA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 13:00:57 -0400
Content-Disposition: inline
In-Reply-To: <loom.20120924T183345-467@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Selso LIBERADO <sli@cioinfoindus.fr>
Cc: linux-omap@vger.kernel.org

* Selso LIBERADO <sli@cioinfoindus.fr> [120924 09:46]:
> Joni Lapilainen <joni.lapilainen <at> gmail.com> writes:
> 
> > 
> > Building tidspbridge fails:
> > 
> >   CC [M]  drivers/staging/tidspbridge/core/tiomap3430.o
> > drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
> > drivers/staging/tidspbridge/core/tiomap3430.c:421:25: error:
> > 'OMAP343X_CTRL_BASE' undeclared (first use in this function)
> > drivers/staging/tidspbridge/core/tiomap3430.c:421:25: note: each
> > undeclared identifier is reported only once for each function it
> > appears in
> > make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> This definition has moved to : arch/arm/mach-omap2/omap34xx.h
> I don't know if we can include directly this file in tiomap3430.c (I'm newbie)

No we should not, that should be private to arch/arm/mach-omap2.
 
> However there is still the symbole  OMAP34XX_WDT3_BASE in
> 'drivers/staging/tidspbridge/core/wdt.c' that is not resolved.

OK it's probably best to define that locally there or in some
drivers/staging/tidispbridge header whatever the code is doing
with it.. Care to do a patch for it? 

Regards,

Tony
