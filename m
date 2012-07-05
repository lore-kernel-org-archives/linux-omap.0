From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3 1/3] ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses
 omap-device.o target so add one entry
Date: Thu, 5 Jul 2012 02:53:51 -0700
Message-ID: <20120705095351.GA1122@atomide.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
 <1340895567-22766-2-git-send-email-hvaibhav@ti.com>
 <20120704072758.GP1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA632CE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17298 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab2GEJxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 05:53:54 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA632CE@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120704 02:21]:
> On Wed, Jul 04, 2012 at 12:57:58, Tony Lindgren wrote:
> >
> > This patch did not apply for some reason, I got:
> > 
> > patching file arch/arm/plat-omap/Makefile
> > patch: **** malformed patch at line 73: 1.7.0.4
> > 
> > So please tune up your scripts a bit to the patches can be applied
> > as they are without manual editing ;)
> > 
> 
> Hmmmm...
> 
> I usually submit the patch against linux-omap/master (to handle cross 
> dependencies), which in some cases fails on other branches you maintain. 
> Probably I will make sure that it allies atleast to relevant branches, for 
> example, in this case it should be applied on linux-omap/cleanup branch as 
> well. 

The malformed patch error usually means that something messed up
the patch, like the mail server.. Maybe tabs got replaced with spaces
or something?

Tony
