From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Beagleboard rev C memory timings & suspend/resume
Date: Fri, 8 May 2009 16:43:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905081527330.17514@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com> <200905071844.20939.jpihet@mvista.com> <alpine.DEB.2.00.0905071257370.17514@utopia.booyaka.com> <200905080905.39102.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54481 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763585AbZEHWno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 18:43:44 -0400
In-Reply-To: <200905080905.39102.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "Kridner, Jason" <jdk@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hello Jean,

On Fri, 8 May 2009, Jean Pihet wrote:

> On Thursday 07 May 2009 20:59:43 Paul Walmsley wrote:
> > On Thu, 7 May 2009, Jean Pihet wrote:
> > > From the OMAP datasheet it looks like the ARCV setting is off: shouldn't
> > > it be (tREFI/tCK)+50=(7800/6)+50=0x546?
> >
> > Could you elaborate further what you're seeing?  It would help to
> > see the register value that you're using to come to this conclusion.
> The SDRC_RFR_CTRL_p registers are now programmed with 0x4dc01, which means the 
> fiel ARCV has the value 0x4dc=1244.
> From the DDR datasheet we need an average refresh period of 7.8us and a clock 
> period of 6ns (166MHz). From the definition of the ARCV field in the OMAP TRM 
> I need to program ARCV with: (tREFI/tCK)+50 = (7800/6)+50=1350=0x546.
> The SDRC_RFR_CTRL_p registers would then have the value of 0x54601.
> 
> Does that make sense? Am I wrong with the calculation?

According to the TRM, the 50 cycles should be subtracted rather than added 
(section 11.2.6.3.3.4).  One other thing is that the bootloaders I've seen 
program DPLL3 such that the SDRC clock is 166000000 Hz, rather than 
166666666 Hz, so tCK winds up being something like 6.024... ns.

Auto-refresh is only used while the SDRC is active, though.  So unless 
memory corruption is evident outside of suspend, the ARCV value is 
unlikely to be the problem.  

It sounds like the problem is related to self-refresh, that the SDRAM bank 
on one of the chipselects either can't enter or exit self-refresh.  You 
have self-refresh working on a different board with both SDRC CS0 and CS1 
in use, correct?  Is that with an ES2 or ES3 chip?

One possibility: perhaps the problem is with Beagle's pin mux settings.  
You might want to boot with mem=128M and make sure 
CONTROL_PADCONF_SAD2D_SBUSFLAG and CONTROL_PADCONF_SDRC_CKE1 are in mode 0 
before suspend and after resume.

Another thought: it could be that the ROM code on Beagle is not 
programming the correct SDRC register values after resume.  You might try 
booting with mem=128M and dumping the SDRC register values before suspend 
and after resume.


- Paul

