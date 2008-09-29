From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Mon, 29 Sep 2008 10:46:33 +0530
Message-ID: <dfeb90390809282216p73e30653l399b165e464440cc@mail.gmail.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
	 <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com>
	 <20080904094655.GB10426@flint.arm.linux.org.uk>
	 <20080904161033.GQ23085@atomide.com>
	 <20080904161248.GC2309@flint.arm.linux.org.uk>
	 <20080904162917.GR23085@atomide.com>
	 <20080904170733.GD2309@flint.arm.linux.org.uk>
	 <20080904175810.GS23085@atomide.com>
	 <alpine.DEB.1.00.0809042312410.25143@utopia.booyaka.com>
	 <alpine.DEB.1.00.0809042357360.25143@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:21525 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYI2FQe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 01:16:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2070869rvb.1
        for <linux-omap@vger.kernel.org>; Sun, 28 Sep 2008 22:16:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0809042357360.25143@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>

Hi All,

I am finished with the ASOC driver for tlvaic23b codec on osk.
I tested the playback and capture.

But have certain issue which stops me from sending the patches.

The system hangs when there is a request for mcbsp in the platform driver
of omap ie.. at
File:sound/soc/omap/omap-mcbsp.c
Function: omap_mcbsp_dai_startup
omap_mcbsp_request(mcbsp_data->bus_id);
This is executed when we do an aplay.

In the ALSA driver(sound/arm/omap/omap-alsa.c:513) the
omap_mcbsp_request() is during the boot time.
There no issues.

So during my testing of the ASOC driver i comment out
omap_mcbsp_request(mcbsp_data->bus_id); from
platform driver (sound/soc/omap/omap-mcbsp.c) and insted requested the
omap_mcbsp in my
moudule_init of machine driver(ie sound/soc/omap/osk.c).

Write which causes this hang is at
File: arch/arm/mach-omap1/mcbsp.c
Function: omap1_mcbsp_request

 __raw_writew(__raw_readw(DSP_RSTCT2) | DPS_RSTCT2_PER_EN |
                                DSP_RSTCT2_WD_PER_EN, DSP_RSTCT2);

Anybody has some clues to fix this.

Thanks
Arun
