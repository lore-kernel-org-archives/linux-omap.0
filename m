From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing
 calculation
Date: Mon, 17 Sep 2012 16:10:02 -0700
Message-ID: <20120917231001.GK11762@atomide.com>
References: <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com>
 <20120911184606.GN23092@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E3624@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E4DFE@DBDE01.ent.ti.com>
 <20120917225023.GJ11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:12388 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754975Ab2IQXKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 19:10:06 -0400
Content-Disposition: inline
In-Reply-To: <20120917225023.GJ11762@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [120917 15:54]:
> * Mohammed, Afzal <afzal@ti.com> [120917 01:40]:
> > Hi Tony,
> > 
> > On Fri, Sep 14, 2012 at 15:50:02, Mohammed, Afzal wrote:
> > > * Mohammed, Afzal: Wednesday, September 12, 2012 3:20 PM
> > 
> > > > But some of the tusb async values is less by one. I need
> > > > to get it right.
> > > 
> > > Reason has been identified. It was due to rounding error,
> > > no changes are required in the expressions. Moving
> > > completely to picoseconds resolves the issue.
> > > 
> > > Can you please try with the attached patch ?
> 
> Gave it a quick try and it seemed to work.. But when I tried
> rebasing my patches for the cbus to keep things working with
> the watchdog, I ran into multiple merge conflicts with
> current linux next and gave up.

OK went back to my original branch without current linux
next and with the new cbus + retu driver from Aaro applied.
Confirmed it's now working on n800 tusb6010.
  
> Care to repost this series updated against current linux
> next?
> 
> I'm afraid I've pretty much lost track of all the patches
> and rather not start resolving the conflicts as I'm sure
> I'll break something else :)

You should still repost the whole updated series against
linux next.

Regards,

Tony
