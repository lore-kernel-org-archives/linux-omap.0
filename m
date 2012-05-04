From: Tony Lindgren <tony@atomide.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Fri, 4 May 2012 10:51:25 -0700
Message-ID: <20120504175124.GI5613@atomide.com>
References: <20120504155255.140b4e3f@skate>
 <87397fewso.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25644 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab2EDRv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 13:51:29 -0400
Content-Disposition: inline
In-Reply-To: <87397fewso.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

* Kevin Hilman <khilman@ti.com> [120504 09:31]:
> Hi Thomas,
> 
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:
> 
> > I have an IGEPv2 revision 6 board, which uses the DM3730 OMAP3. With
> > 3.2 omap2plus_defconfig, the system boots fine and have a working shell
> > on ttyO2. On either 3.3, 3.4-rc5 or arm-soc/for-next from Arnd, the
> > system boots all the way up to showing the shell prompt, but I can't
> > type any character, as if UART RX was broken.
> 
> On v3.4-rc, can you see if reverting bce492c04ba8fc66a4ea0a52b181ba255daaaf54
> has any effect?
> 
> That patch had some unfortunate side effects, but I haven't seen the
> problem you see, so I'm not sure if it's related.

Reverting bce492c04ba8fc66a4ea0a52b181ba255daaaf54 is a broken solution
like you mentioned. But if it helps, then the proper fix is to add muxing
to board-*.c files for the uart pins and use omap_serial_init_port
for each uart instead of omap_serial_init. That should fix the wake-up
issues too.

Regards,

Tony
