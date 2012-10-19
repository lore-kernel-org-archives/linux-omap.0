From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Fri, 19 Oct 2012 08:16:30 +0200
Message-ID: <20121019061630.GB2983@netboy.at.omicron.at>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at>
 <50806B1D.9040504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34484 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab2JSGQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 02:16:41 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so119331wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 23:16:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50806B1D.9040504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> 
> Another important point is, this driver is also required and used for
> Davinci family of devices (arch/mach/mach-davinci/).

That is really beside the point. If the code isn't ready yet, then
don't merge it.

When I asked about the beaglebone, I was given the impression that it
will be ready for v3.7-rc1.  But, as I know realize, at the current
rate, it might not even be ready for v3.8.

I don't mind waiting, but please make sure that whatever lands into a
release is really, truly working.

Thanks,
Richard


