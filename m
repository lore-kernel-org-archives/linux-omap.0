From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 10 Jul 2012 10:04:57 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A64D0@DBDE01.ent.ti.com>
References: <20120702063651.GO4202@atomide.com> <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
 <20120706120533.GU1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
 <20120710094538.GT1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49626 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab2GJKFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 06:05:09 -0400
In-Reply-To: <20120710094538.GT1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Tue, Jul 10, 2012 at 15:15:38, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120709 23:24]:
> > On Fri, Jul 06, 2012 at 17:35:33, Tony Lindgren wrote:

> > > format. But the peripheral specific retime function still needs to be
> > > also registered for peripherals that need it.
> > 
> > For the peripherals requiring retime, we cannot (as otherwise whatever
> > retime does would have to be manually done based on the knowledge of
> > boot time gpmc clock period to calculate gpmc timings to be fed to DT)
> > pass gpmc timings via device tree, right ?
> 
> We can still do it when the connected peripheral probe registers with
> gpmc.

We can, but would it be feasible practically ?, gpmc timings to update in
DT for a such a peripheral (requiring retime) can be found out only by
manual calculation similar to the way done in retime function (based on
peripheral's timings and boot time gpmc clock period), correct ?, Also
wouldn't this make it necessary to know gpmc clock period at boot time
for properly updating gpmc timing entry in DT ?

And in this case, we are going to register retime function, so instead of
relying on DT to provide gpmc timings for such a peripheral, won't it
be better to make use of retime that is already registered ?

 
Regards
Afzal
