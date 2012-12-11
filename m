From: Paul Walmsley <paul@pwsan.com>
Subject: Re: kexec: cpufreq: omap3: hangs in
 dpll3xxx.c::_omap3_dpll_write_clken()
Date: Tue, 11 Dec 2012 20:32:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212112025160.26612@utopia.booyaka.com>
References: <20121211150343.GA4261@luxor.wired.org> <alpine.DEB.2.00.1212112019320.26612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47233 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2LKUc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 15:32:26 -0500
In-Reply-To: <alpine.DEB.2.00.1212112019320.26612@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, 11 Dec 2012, Paul Walmsley wrote:

> On Tue, 11 Dec 2012, Paolo Pisati wrote:
> 
> > I've been experiencing solid hangs on my beaglexm with v3.7 after
> > kexec:
> 
> Does it crash if you boot v3.7 directly from the bootloader, i.e., without 
> kexec?

Also you might want to verify that the voltage on VDD1 is what the kernel 
thinks it is:

[    5.638183] notification 0 of frequency transition to 800000 kHz
[    5.644775] cpu cpu0: cpufreq-omap: 300 MHz, -1 mV --> 800 MHz, 1325 mV

You can probe this with a multimeter on one side of the VDD1 inductor.  
It's on the underside of the Beagle-XM near the DC input jack - it's 
marked "L4" on the silkscreen text.


- Paul
