From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 14 Jun 2012 05:30:16 -0700
Message-ID: <20120614123016.GN12766@atomide.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614114905.GK12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999B05@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999B34@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23304 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab2FNMaS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 08:30:18 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E999B34@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120614 05:25]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 17:39:41, Mohammed, Afzal wrote:
> > On Thu, Jun 14, 2012 at 17:19:06, Tony Lindgren wrote:
> 
> > > For onenand I'm getting the following error:
> > > 
> > > omap2-onenand omap2-onenand: Cannot request GPMC CS 
> > 
> > I am a bit confused with this message, for onenand, we only have,
> > 
> > pr_err("%s: Cannot request GPMC CS\n", __func__);
> > 
> > dev_err is used only for nand
> 
> This error can happen if my patches are not present,
> 
> dev_err for onenand driver was removed by,
> 
> [mtd: onenand: omap2: obtain memory from resource],
> 
> seems, mtd patches are not in your present branch

OK, I'll try with those.

Tony
