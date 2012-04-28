From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Fri, 27 Apr 2012 18:04:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204271804010.10308@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204260246170.10308@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA00AC6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39267 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757775Ab2D1AEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 20:04:54 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA00AC6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 27 Apr 2012, Hiremath, Vaibhav wrote:

> On Thu, Apr 26, 2012 at 14:19:28, Paul Walmsley wrote:
> > looking at Table 1-1 "Device Features" of SPRUH73D, it seems that some 
> > AM33xx family chips come with some features disabled, such as the 
> > PRU-ICSS, the SGX, Ethernet, or USB.  How will this affect the clock tree?  
> > For example, is it correct for us to include the PRU-ICSS clock control on 
> > a clock tree that is booted on an AM3352 or an AM3354?
> 
> I thought of this, but if you look at the existing way of handling such 
> Si version based clock registration is supported by "cpu_clkflg", like 
> CK_3XXX, CK_AM35XX, etc...
> 
> During my baseport patch submission, Tony had removed CK_AM33XX flag while 
> merging them. I believe, we are trying to get rid of these flags, and that's 
> where Tony had removed them form my baseport patch.
> I was not sure on how to handle this, so I decided to continue with full 
> chip support (AM3358 and AM3359).

Okay, no problem.  Sounds like we should start with full support and then 
remove clocks later if they cause problems on the lower-end devices.


- Paul
