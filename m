From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Thu, 7 Jun 2012 14:03:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206071355090.14977@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061309.25532.13430.stgit@dusk> <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206070107530.6684@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA44DD9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41207 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab2FGUDr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 16:03:47 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA44DD9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi

On Thu, 7 Jun 2012, Hiremath, Vaibhav wrote:

> I couldn't finish my testing today, got into continuous meetings.

No worries, I understand.

> Tomorrow, I will test it and update you on this.

That would be great.

I took a look at SPRUH73F and sure enough, at least one module (CONTROL) 
doesn't support smart-idle -- per Table 14-217 "CONTROL Register Field 
Descriptions".  I'd guess that the PRCM won't idle-req this IP block until 
the kernel is not running, so we might be able to get away with the 
existing approach; but the TRM also says:

"By definition, initiator may generate read/write transaction as long as
it is out of IDLE state."

Which pretty much matches my understanding too of the implicit interface 
contract here.

So I think we'd better go back to the flag approach as implemented in this 
patch:

http://www.spinics.net/lists/arm-kernel/msg176836.html

The WBU 32k sync timer's behavior is what relies on quirks of the 
integration that are hard to identify via other means, so it seems to be 
safest to tag it explicitly.


- Paul
