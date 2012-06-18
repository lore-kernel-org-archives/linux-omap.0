From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V2 0/4] ARM: OMAP2+: am33xx: Add clocktree and hwmod
 data
Date: Mon, 18 Jun 2012 12:28:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206181227230.11642@utopia.booyaka.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com> <79CD15C6BA57404B839C016229A409A83EA50AF1@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206181206000.11642@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA54713@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39083 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2FRS2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 14:28:38 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA54713@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 18 Jun 2012, Hiremath, Vaibhav wrote:

> I would really recommend you to look at the proposal of getting the clock-
> tree and hwmod patches to the linux-next until merge window, so that it will 
> get tested for some time.

I've thought about this, but I'm not sure it has much point unless Tony's 
tree goes to linux-next, since that's where the OMAP integration happens.


- Paul
