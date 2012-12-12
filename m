From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: kexec: cpufreq: omap3: hangs in
 dpll3xxx.c::_omap3_dpll_write_clken()
Date: Wed, 12 Dec 2012 09:53:00 +0100
Message-ID: <20121212085300.GB4272@luxor.wired.org>
References: <20121211150343.GA4261@luxor.wired.org>
 <alpine.DEB.2.00.1212112019320.26612@utopia.booyaka.com>
 <alpine.DEB.2.00.1212112025160.26612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53707 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab2LLIxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 03:53:04 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so228523eek.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Dec 2012 00:53:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212112025160.26612@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Paolo Pisati <p.pisati@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Dec 11, 2012 at 08:32:25PM +0000, Paul Walmsley wrote:
> On Tue, 11 Dec 2012, Paul Walmsley wrote:
> 
> > On Tue, 11 Dec 2012, Paolo Pisati wrote:
> > 
> > > I've been experiencing solid hangs on my beaglexm with v3.7 after
> > > kexec:
> > 
> > Does it crash if you boot v3.7 directly from the bootloader, i.e., without 
> > kexec?
> 
> Also you might want to verify that the voltage on VDD1 is what the kernel 
> thinks it is:
> 
> [    5.638183] notification 0 of frequency transition to 800000 kHz
> [    5.644775] cpu cpu0: cpufreq-omap: 300 MHz, -1 mV --> 800 MHz, 1325 mV
> 
> You can probe this with a multimeter on one side of the VDD1 inductor.  
> It's on the underside of the Beagle-XM near the DC input jack - it's 
> marked "L4" on the silkscreen text.

uhm no, my multimeter says it's around 113mV...

-- 
bye,
p.
