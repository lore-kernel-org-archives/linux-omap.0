From: Selso LIBERADO <sli@cioinfoindus.fr>
Subject: Re: tidspbridge build fails
Date: Mon, 24 Sep 2012 16:37:59 +0000 (UTC)
Message-ID: <loom.20120924T183345-467@post.gmane.org>
References: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51226 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756848Ab2IXQpD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 12:45:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TGBmJ-00053K-Ld
	for linux-omap@vger.kernel.org; Mon, 24 Sep 2012 18:45:03 +0200
Received: from 195.6.193.205 ([195.6.193.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 18:45:03 +0200
Received: from sli by 195.6.193.205 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 18:45:03 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Joni Lapilainen <joni.lapilainen <at> gmail.com> writes:

> 
> Building tidspbridge fails:
> 
>   CC [M]  drivers/staging/tidspbridge/core/tiomap3430.o
> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
> drivers/staging/tidspbridge/core/tiomap3430.c:421:25: error:
> 'OMAP343X_CTRL_BASE' undeclared (first use in this function)
> drivers/staging/tidspbridge/core/tiomap3430.c:421:25: note: each
> undeclared identifier is reported only once for each function it
> appears in
> make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

This definition has moved to : arch/arm/mach-omap2/omap34xx.h
I don't know if we can include directly this file in tiomap3430.c (I'm newbie)

However there is still the symbole  OMAP34XX_WDT3_BASE in
'drivers/staging/tidspbridge/core/wdt.c' that is not resolved.



