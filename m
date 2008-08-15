From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: JTAG debugging of the kernel
Date: Fri, 15 Aug 2008 23:04:07 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208C16544@dbde02.ent.ti.com>
References: <1218812628.24975.89.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47728 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722AbYHOReT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 13:34:19 -0400
In-Reply-To: <1218812628.24975.89.camel@blackhole>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter
> Barada
> Sent: Friday, August 15, 2008 8:34 PM
> To: linux-omap@vger.kernel.org
> Subject: JTAG debugging of the kernel
> 
> I've been trying to use JTAG (and an Abatron BDI-2000) to debug the ALSA
> driver to determine why madplay can't keep up when pulling .mp3 from an
> SD card, and have not had any luck trying to halt via JTAG and set/stop
> at breakpoints within the kernelthe kernel.  I've found that JTAG works
> for a while on kernel startup, but stops working at a non-reproducible
> point in the startup code.
> 
> Have people had success using a BDI-2000 to debug the kernel after it
> has completed startup?
> 
> Any suggestions on what can cause the JTAG to stop working after the
> kernel starts?
> 

I think you should disable Power Management. Which kernel are you using now?

Regards,
Khasim
