From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 0/4] ARM: OMAP2+: am33xx: Add clocktree and hwmod data
Date: Mon, 18 Jun 2012 18:46:43 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5477F@DBDE01.ent.ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA50AF1@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206181206000.11642@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA54713@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206181227230.11642@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60987 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab2FRSqw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 14:46:52 -0400
In-Reply-To: <alpine.DEB.2.00.1206181227230.11642@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 18, 2012 at 23:58:36, Paul Walmsley wrote:
> On Mon, 18 Jun 2012, Hiremath, Vaibhav wrote:
> 
> > I would really recommend you to look at the proposal of getting the clock-
> > tree and hwmod patches to the linux-next until merge window, so that it will 
> > get tested for some time.
> 
> I've thought about this, but I'm not sure it has much point unless Tony's 
> tree goes to linux-next, since that's where the OMAP integration happens.
> 

Yes, make sense. I also meant same thing, it should be along with Tony's 
pull request -

Tony's Tree (for linux-next) + Your Branch (AM335x prm/cm/clkdm/pwrdm) + 
AM335x Clock Tree and HWMOD.

Thanks,
Vaibhav


