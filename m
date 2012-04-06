From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Fri, 6 Apr 2012 10:41:29 -0700
Message-ID: <20120406174129.GA15734@atomide.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C47AD@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204050414570.10302@utopia.booyaka.com>
 <CAMrsUdJV_JVmqqyR7fpX+efOr9Z43oZX0FkJN5Q7-f2YkFFvJQ@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C4B2B@DBDE01.ent.ti.com>
 <20120405171653.GD3785@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C5D65@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16145 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666Ab2DFRld (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 13:41:33 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C5D65@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Mohammed, Afzal <afzal@ti.com> [120405 21:57]:
> Hi Tony,
> 
> On Thu, Apr 05, 2012 at 22:46:53, Tony Lindgren wrote:
> > What happens if you disable CONFIG_OMAP_MUX?
> 
> Then it boots properly.

OK, so that's because then the mux interrupts won't
get enabled like you noticed elsewhere in the thread.

So something in Paul's series is changing the interrupt
behaviour somehow?

Tony
