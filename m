From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Fri, 6 Apr 2012 12:08:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204061159100.11100@utopia.booyaka.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A9317C47AD@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204050414570.10302@utopia.booyaka.com> <CAMrsUdJV_JVmqqyR7fpX+efOr9Z43oZX0FkJN5Q7-f2YkFFvJQ@mail.gmail.com> <C8443D0743D26F4388EA172BF4E2A7A9317C4B2B@DBDE01.ent.ti.com> <20120405171653.GD3785@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A9317C5D65@DBDE01.ent.ti.com>
 <20120406174129.GA15734@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59508 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab2DFSId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 14:08:33 -0400
In-Reply-To: <20120406174129.GA15734@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, khilman@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

cc Kevin

On Fri, 6 Apr 2012, Tony Lindgren wrote:

> So something in Paul's series is changing the interrupt
> behaviour somehow?

Am wondering if this might be due to the kernel not clearing some 
bootloader mux settings?

Perhaps the bootloader is configuring the mux hardware for I/O wakeups on 
a pad, but the kernel is missing an mux IRQ handler or mapping for it. Or 
maybe one of the kernel mux entries is missing the OMAP_WAKEUP_EN or 
OMAP_DEVICE_PAD_WAKEUP flags for a pad that the bootloader is configuring 
- I seem to recall that Kevin found some problems here with the 
mach-omap2/serial.c mux code.  Anyway, will create a patch to add some 
debugging here for Afzal to try.

Also,it seems to me that when the mux layer starts, the code should 
probably clear out all of the I/O wakeup configuration in the hardware 
that the bootloader set up.


- Paul
