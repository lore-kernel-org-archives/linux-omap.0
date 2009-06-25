From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
 event
Date: Thu, 25 Jun 2009 20:45:56 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BDB1387E@dnce02.ent.ti.com>
References: <1245702865-4459-1-git-send-email-ubh@ti.com>
 <alpine.DEB.2.00.0906221915540.9637@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5259C55@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0906222113200.9637@utopia.booyaka.com>
 <00695C9C8F8B4448856F48142B4AA201BDA38C4A@dnce02.ent.ti.com>
 <alpine.DEB.2.00.0906231146550.6545@utopia.booyaka.com>
 <alpine.DEB.2.00.0906231513280.6545@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44430 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbZFYSqC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 14:46:02 -0400
In-Reply-To: <alpine.DEB.2.00.0906231513280.6545@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Paul,
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, June 23, 2009 4:18 PM
> To: Hald, Ulrik Bech
> Cc: Pakaravoor, Jagadeesh; linux-omap@vger.kernel.org
> Subject: RE: [PATCH v2 1/1] i2c:OMAP3:Errata workaround for spurious RDR
> event
> 
> On Tue, 23 Jun 2009, Paul Walmsley wrote:
> 
> > Okay.  So it looks like there is a unfixable race here.  Is it possible
> > for BB to be 0 during the stat2 read, then for BB to go to 1 immediately
> > afterwards?  Then the rest of the RDR handler would be entered.  If this
> > is possible, what will the ISR do -- will it hang?
> 
> By the way, it would also be helpful if you could check what the "certain
> rare conditions" are that erratum 1.15 refers to that cause this
> problem...
> 
Yeah, I would like to know that too, but unfortunately the errata specification (which is all I have to lean on) doesn't say.
> 
> - Paul

Ulrik
