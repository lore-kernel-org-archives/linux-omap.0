From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Fri, 5 Jul 2013 13:20:10 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
References: <51D577E6.5010507@newflow.co.uk>
 <51D59146.3070002@newflow.co.uk> <51D59C0E.8080003@newflow.co.uk>
 <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com>
 <20130705115959.GQ5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51673 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156Ab3GENUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 09:20:43 -0400
In-Reply-To: <20130705115959.GQ5523@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Jackson <mpfj-list@newflow.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Fri, Jul 05, 2013 at 17:29:59, Tony Lindgren wrote:
> * Bedia, Vaibhav <vaibhav.bedia@ti.com> [130705 01:17]:
> > 
> > I just checked the behavior on my AM335x-EVM. Current mainline boots fine
> > provided I don't use earlyprintk.  The offending patch [1] in this case is the one
> > that tries to get rid of omap_serial_early_init() for DT boot. This change inadvertently
> > also results in the console UART getting reset and idled during bootup and that's where
> > the boot stops for you. I think if you skip earlyprintk from the bootargs you should see
> > the system booting fine. 
> > 
> > I guess we need to retain the NO_IDLE and NO_RESET aspect for the console UART in
> > omap_serial_early_init() to get earlyprintk working again.
> 
> Hmm nothing should get idled while earlyprintk is running, and then when the
> serial driver kicks in it should not idle anything by default. And for DT based
> booting we should not have mach-omap2/serial.c initialize anything.
> 

If I add in the HWMOD flags without any reverts I get to the point where the serial driver
comes up but the boot eventually stops [1]. Without the flags the boot stops much earlier [2]
just like Mark reported.

> I wonder if this is because the timeouts get now initialized to 0 instead
> of -1 for the serial driver?
> 

You meant initialized to -1, right? There's an additional check for timeout being 0. Unless i
am missing something DT-boot will start off with timeout set to 0 and then get forced to -1.

Regards,
Vaibhav

===
[1]

[    0.000000] Booting Linux on physical CPU 0x0
<...>
[    0.190107] SMP: Total of 1 processors activated (363.72 BogoMIPS).
[    0.196711] CPU: All CPU(s) started in SVC mode.
[    0.205580] devtmpfs: initialized
<stops here if booted with earlyprintk>

[2]
[    0.000000] Booting Linux on physical CPU 0x0
<...>
[    1.453364] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    1.467121] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
<stops here if booted with earlyprintk>
