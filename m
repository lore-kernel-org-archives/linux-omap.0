From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
Date: Tue, 10 Jul 2012 02:43:08 -0700
Message-ID: <20120710094308.GS1122@atomide.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com>
 <20120627161745.GO3483@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA5C2C4@DBDE01.ent.ti.com>
 <20120710084107.GO1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69AA3@DBDE01.ent.ti.com>
 <20120710091820.GR1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69AFE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25964 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab2GJJnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 05:43:11 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA69AFE@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120710 02:29]:
> On Tue, Jul 10, 2012 at 14:48:21, Tony Lindgren wrote:
> > 
> > We have quite a few initcalls that exit early with various soc_is, cpu_is,
> > cpu_class_is tests that would fail for multi zImage kernels. Some of these
> > have been patched away with additional calls in MACHINE_START, but some
> > still remain.
> > 
> Let me check on this inside code but if you have any quick reference, please 
> let me know, I can fix it and submit the patch.

Any initcall that returns early if (!cpu_class_is_omap2()) would continue
running on multi zImage kernel on other SoCs compiled in unless we check
for each cpu_is_omapxxxx() || soc_is_omapxxxx() tests like we currently
do.

Regards,

Tony
