From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH] arm:omap: cleanup & split omap2/3/4_check_revision
 function
Date: Thu, 8 Dec 2011 09:14:17 -0800
Message-ID: <20111208171417.GA31337@atomide.com>
References: <1320676991-32152-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A803D9D5@DBDE01.ent.ti.com>
 <20111207234119.GQ31337@atomide.com>
 <79CD15C6BA57404B839C016229A409A8050F45@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25267 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750912Ab1LHROU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 12:14:20 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8050F45@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [111208 05:08]:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > 
> > Maybe just call ti816x_check_features separately?
> > 
> > 	omap3xxx_check_revision();
> > 	omap3xxx_check_features();
> > and
> > 	omap3xxx_check_revision();
> > 	ti816x_check_features();
> > 
> The reason why I did not do this is,
> 
> In case of omap3_check_revision, 
> 
> Void __init omap3xxx_check_revision()
> {
> 	const char *cpu_rev;
> 
> 	omap3_check_revision(&cpu_rev);
> 	omap3_check_features();
> 	omap3_cpuinfo(cpu_rev);
> }
> 
> 
> If I separate, omap3_check_revision() and omap3_check_features(), then I 
> have to maintain cpu_rev in the parent function. Also, I can not break the 
> sequence due to this dependency on cpu_rev. and I wanted to retain the void
> function calls in omap3_init_early().
> So I came up with this optimized and clean way of using "has_feature_reg" 
> Flag, and set to default features for AM family of devices.
> 
> OR
> As you suggested, I have to maintain cpu_rev into function 
> omap3_init_early() and call the above 3 function in the sequence
> (alone for omap3).

Let's still plan on separating check_revision and check_features
so we can simplify things. How about something like this:

static const char *cpu_rev;

void __init omap3xxx_check_revision(void)
{
	...
}

static void __init omap3_cpuinfo()
{
	...
}

void __init omap3xxx_check_features(void)
{
	...
	omap3_cpuinfo();
}

void __init ti816x_check_features(void)
{
	...
	omap3_cpuinfo();
}

Then we can easily add whatever combinations are needed
and hopefully can move check_features to happen later on
eventually.

Regards,

Tony
