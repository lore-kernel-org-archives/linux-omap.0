From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Sat, 15 Dec 2012 00:37:52 +0000
Message-ID: <20121215003752.D0BE63E0BEF@localhost>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com> <1354734571-10774-6-git-send-email-zonque@gmail.com> <20121205222232.67B2B3E0E22@localhost> <50BFCBCC.6030706@ti.com> <20121205232426.BAD573E0E22@localhost> <50C0C5AB.3030201@ti.com> <50C84AC6.5030307@gmail.com> <50C90CF2.1090405@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:46277 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab2LOAiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 19:38:09 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1632409wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 16:38:07 -0800 (PST)
In-Reply-To: <50C90CF2.1090405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Daniel Mack <zonque@gmail.com>
Cc: paul@pwsan.com, x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, tony@atomide.com, jacmet@sunsite.dk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 12 Dec 2012 17:02:10 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
> 
> So looking at this today, here is what I see when comparing the
> registers ...
> 
> omap2430 != omap2420
> omap3430 != omap2430
> omap3630 == omap3430
> omap4430 != omap3430
> omap4460 == omap4430
> omap543x == omap4430
> am335x != omap4430
> 
> Therefore, I believe that we need to have the following compatible
> strings ...
> 
> ti,omap2420-gpmc
> ti,omap2430-gpmc
> ti,omap3430-gpmc (omap3430 & omap3630)
> ti,omap4430-gpmc (omap4430 & omap4460 & omap543x)
> ti,am3352-gpmc (am335x devices)
> 
> Probably worth adding a comment to the Documentation what should be used
> for which device.

Yes, it is completely appropriate to add a comment to the documentation
here so this doesn't get lost.

g.

