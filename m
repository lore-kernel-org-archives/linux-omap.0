From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] GPMC NAND isr using standard API
Date: Tue, 22 May 2012 09:44:15 -0700
Message-ID: <20120522164413.GF16308@atomide.com>
References: <cover.1337090835.git.afzal@ti.com>
 <20120519125018.GA2407@parrot.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98EE28@DBDE01.ent.ti.com>
 <1337667283.2483.83.camel@sauron.fi.intel.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98F0E1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58544 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab2EVQoV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 12:44:21 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98F0E1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, Ivan Djelic <ivan.djelic@parrot.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120522 00:05]:
> Hi Artem,
> 
> On Tue, May 22, 2012 at 11:44:43, Artem Bityutskiy wrote:
> > You merge the 2 trees and work on top of that? Or you wait for 3.5-r1
> > when everything is merged and work on top of that?
> 
> I will merge 2 trees & do
> 
> Tony, are you ok with that ?

I suggest you guys do your own merge of the two trees until -rc1
is out, then start using -rc1 as the base like Artem suggested.

Regards,

Tony
