From: Jean Pihet <jpihet@mvista.com>
Subject: Re: Beagleboard rev C memory timings & suspend/resume
Date: Fri, 8 May 2009 10:13:02 +0200
Message-ID: <200905081013.02445.jpihet@mvista.com>
References: <200904291553.49378.jpihet@mvista.com> <200905071318.30501.jpihet@mvista.com> <alpine.DEB.2.00.0905071316160.17514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:62824 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbZEHINX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 04:13:23 -0400
In-Reply-To: <alpine.DEB.2.00.0905071316160.17514@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Kridner, Jason" <jdk@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thursday 07 May 2009 21:18:41 Paul Walmsley wrote:
> Hello Jean,
>
> one other suggestion.  You mentioned that you had self-refresh working on
> another OMAP3430 board with two SDRAM chip-selects.  You might consider
> dumping the SDRC registers from that board, and dumping the SDRC registers
> on Beagle rev C, and comparing.  It could be that the bootloader on your
> other board is setting some important bit.
The comparison gives the following:
- the timings are slightly different but given that the parts are not the same 
I do not think it is a problem
- the fields FIXEDDELAY and MODEFIXEDDELAYINITLAT are set in SDRC_DLLA_CTRL, 
the register value is 0x2600000A. Does that affect the 166MHz operation?
- the field DEEPPD of SDRC_MCFG_p is set to 0. That setting could affect the 
suspend/resume
- the MUX scheme is different: ADDRMUXLEGACY is set to 0
- the field BANKALLOCATION of SDRC_MCFG_p is set to 0 instead of 2

I tried to change those fields on the Beagleboard but still suspending for 
more than 10sec corrupts the memory.

> - Paul

Regards,
Jean
