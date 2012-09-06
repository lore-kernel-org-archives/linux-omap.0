From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing
 calculation
Date: Thu, 6 Sep 2012 13:43:54 -0700
Message-ID: <20120906204354.GJ1303@atomide.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:58344 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759901Ab2IFUn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:43:57 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120906 00:40]:
> Hi Tony,
> 
> On Mon, Sep 03, 2012 at 11:04:10, Mohammed, Afzal wrote:
> > On Mon, Aug 27, 2012 at 14:04:44, Mohammed, Afzal wrote:
> > > On Sat, Aug 25, 2012 at 01:16:30, Tony Lindgren wrote:
> 
> > > > This hangs n800 during the boot.
> 
> Paul reported that n800 stopped booting on OMAP baseline [1]
> due to an mmc issue and has posted a solution [2].
> 
> Are you facing the same issue ?, if so, then it is not
> due to this series.

No that's a separate issue. Your series works except for
this patch makes thing hang.

Regards,

Tony
 
> I tried to get an n800, but has been unsuccessful.
> 
> Regards
> Afzal
> 
> [1] http://marc.info/?l=linux-omap&m=134685988517580&w=2
> [2] http://www.spinics.net/lists/arm-kernel/msg190879.html
> 
> 
> > > 
> > > Shall I read the above as n800 boot without patch 10/10,
> > > but with the other patches in this series ?
> > > 
> > > As per the board file, n800 has tusb6010 as well as
> > > OneNAND in sync read & async write mode, was OneNAND
> > > working without 10/10.
> > > 
> > > Do you have any idea, which timing could have gone wrong,
> > > can you please sent me DEBUG enabled gpmc log with and
> > > without 10/10.
> > 
> > Can you please sent me GPMC DEBUG enabled logs with and
> > without this series.
> 
