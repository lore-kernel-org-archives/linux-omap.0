From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Fri, 26 Oct 2012 08:23:23 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB4B4D0@DBDE01.ent.ti.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at> <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB48592@DBDE01.ent.ti.com>
 <20121024050853.GA2124@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757299Ab2JZIXc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 04:23:32 -0400
In-Reply-To: <20121024050853.GA2124@netboy.at.omicron.at>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 24, 2012 at 10:38:53, Richard Cochran wrote:
> On Tue, Oct 23, 2012 at 10:12:29AM +0000, Hiremath, Vaibhav wrote:
> > 
> > I understand, and as you mentioned we are not fully there at v3.7-rc1 with 
> > all the drivers/module support, due to all known reasons. Its good that with 
> > v3.7-rc2, Beaglebone boots up out of box from mainline. 
> 
> Can you say whether we have working Ethernet on the beaglebone in v3.7?
> 

No, certainly not. The DT patches are still pending to get merged and v3.7 
merge window is closed now. I expect it to get merged to v3.8.

Thanks,
Vaibhav

> Thanks,
> Richard
> 

