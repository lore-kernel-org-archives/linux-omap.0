From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
Date: Wed, 6 Feb 2013 08:56:16 -0800
Message-ID: <20130206165616.GW25185@atomide.com>
References: <50FE64DC.2030808@ti.com>
 <510788B9.9050907@ti.com>
 <20130130220532.GA22517@atomide.com>
 <20130204195251.GS22517@atomide.com>
 <5110D4ED.6030306@ti.com>
 <20130205184014.GK25185@atomide.com>
 <51120494.6020407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18744 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751724Ab3BFQ4T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 11:56:19 -0500
Content-Disposition: inline
In-Reply-To: <51120494.6020407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130205 23:25]:
> On 02/05/2013 07:40 PM, Tony Lindgren wrote:
> >> For some reason the CONFIG_DEBUG_SECTION_MISMATCH got disabled in my rolling
> >> kernel config...
> > 
> > At least gcc version 4.3.5 (Debian 4.3.5-4) shows them. What's
> > the compiler you have? 
> 
> It show for me as well now that I have enabled the
> CONFIG_DEBUG_SECTION_MISMATCH in my config.

Maybe update your build scripts to always just:
$ ARCH=arm CONFIG_DEBUG_SECTION_MISMATCH=y make ...
 
> My GCC is:
> armv7a-hardfloat-linux-gnueabi-gcc (Gentoo 4.7.2 p1.3, pie-0.5.5) 4.7.2
> 
> > Yes let's do that rather than start copying things around. I'll apply
> > the following fix to the omap-for-v3.9/twl branch.
> 
> Cool, thanks Tony. I will drop my patch and pick the one from omap-for-v3.9/twl.

OK will send that off today then.

Regards,

Tony
