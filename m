From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Beagleboard rev C memory timings & suspend/resume
Date: Fri, 8 May 2009 16:51:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905081647580.17514@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com> <200905071318.30501.jpihet@mvista.com> <alpine.DEB.2.00.0905071316160.17514@utopia.booyaka.com> <200905081013.02445.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57053 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZEHWvq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 18:51:46 -0400
In-Reply-To: <200905081013.02445.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "Kridner, Jason" <jdk@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 8 May 2009, Jean Pihet wrote:

> On Thursday 07 May 2009 21:18:41 Paul Walmsley wrote:
> > Hello Jean,
> >
> > one other suggestion.  You mentioned that you had self-refresh working on
> > another OMAP3430 board with two SDRAM chip-selects.  You might consider
> > dumping the SDRC registers from that board, and dumping the SDRC registers
> > on Beagle rev C, and comparing.  It could be that the bootloader on your
> > other board is setting some important bit.
> The comparison gives the following:
> - the timings are slightly different but given that the parts are not the same 
> I do not think it is a problem
> - the fields FIXEDDELAY and MODEFIXEDDELAYINITLAT are set in SDRC_DLLA_CTRL, 
> the register value is 0x2600000A. Does that affect the 166MHz operation?

It shouldn't.

> - the field DEEPPD of SDRC_MCFG_p is set to 0. That setting could affect the 
> suspend/resume

I don't think this should matter, since we never power off the SDRAM.

> - the MUX scheme is different: ADDRMUXLEGACY is set to 0
> - the field BANKALLOCATION of SDRC_MCFG_p is set to 0 instead of 2

- Paul
