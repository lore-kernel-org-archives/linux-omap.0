From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: OMAP baseline test results for v3.14
Date: Thu, 3 Apr 2014 15:32:37 +0200
Message-ID: <20140403133237.GA6019@luxor.wired.org>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
 <20140402162102.GB12234@atomide.com>
 <alpine.DEB.2.02.1404021631040.15928@utopia.booyaka.com>
 <20140402163521.GD12234@atomide.com>
 <CAGo_u6qJt5BRQHDvRjWe7Gjt+AfEBxaOPxCnq66QxMUdZew3Vg@mail.gmail.com>
 <20140402171513.GE12234@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:48447 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaDCNcl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2014 09:32:41 -0400
Received: by mail-wi0-f176.google.com with SMTP id r20so9185790wiv.9
        for <linux-omap@vger.kernel.org>; Thu, 03 Apr 2014 06:32:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140402171513.GE12234@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>, Balaji T K <balajitk@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel-build-reports@lists.linaro.org

On Wed, Apr 02, 2014 at 10:15:13AM -0700, Tony Lindgren wrote:
> > Paul uses MMC filesystem, I use NFS. As Felipe Pointed out as well, I
> > did rootcause MMC filesystem mount issue here:
> > http://marc.info/?l=linux-omap&m=139637044425644&w=2
> 
> Balaji, care to take a look at the issue for MMC? It may
> be already fixed in next with the PBIAS handling?

it may be related (or not), but i'm experiencing reboot issues with 3.13/.14 on
omap4 (panda), and after a bisection i found out that reverting 

commit e002264f7e45d7661b237045577052fd0b40f89c
Author: Balaji T K <balajitk <at> ti.com>
Date:   Mon Oct 21 00:25:18 2013 +0530

    mmc: omap_hsmmc: Fix pbias_disable for omap4

    pbias_disable is set to protect the mmc pbias i/o cells in DT boot
    by preventing voltage switch. Currently pbias_disable is enabled only
    for omap3 and not for omap4 due to reg_offset difference of 0x100.
    Enable pbias_disable for omap4+ too by using res->start
    which does not include the reg_offset.

    Signed-off-by: Balaji T K <balajitk <at> ti.com>
    Signed-off-by: Chris Ball <cjb <at> laptop.org>

made it go away: can you point me to those pbias handling patches (i guess
something about dt-booting handling pbias correctly now)?

Root on mmc in my case.
-- 
bye,
p.
