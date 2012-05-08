From: Paul Walmsley <paul@pwsan.com>
Subject: Re: AM3517 boot failure
Date: Tue, 8 May 2012 09:49:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205080946570.9984@utopia.booyaka.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com> <4F8FC572.80406@compulab.co.il> <alpine.DEB.2.00.1205072349540.9984@utopia.booyaka.com> <87pqaesrx0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41474 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab2EHPt1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 11:49:27 -0400
In-Reply-To: <87pqaesrx0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

Hi Kevin,

thanks for the suggestion,

On Tue, 8 May 2012, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > On Thu, 19 Apr 2012, Igor Grinberg wrote:
> >
> >> IMO this can be seen on any AM35xx based board with EMAC, or am I mistaken?
> >
> > Just tested this on a 3517EVM and the same problem is there too.
> 
> Does adding nohlt on the cmdline make a difference?
> 
> The AM35x has known wakeup limitations, and nohlt would at least avoid
> WFI to see if it's the wakeup problems that are the root cause here.

Adding 'nohlt' allows it to go a little farther in the boot, but still 
hangs.  Log below.

(Without 'nohlt', it hangs right after "calling  ip_auto_config+0x0/0xf70 
@ 1")


- Paul

[    6.250946] calling  net_secret_init+0x0/0x1c @ 1
[    6.255981] initcall net_secret_init+0x0/0x1c returned 0 after 119 
usecs
[    6.263092] calling  tcp_congestion_default+0x0/0xc @ 1
[    6.268646] initcall tcp_congestion_default+0x0/0xc returned 0 after 29 
usecs
[    6.276184] calling  ip_auto_config+0x0/0xf70 @ 1
[    6.325500] mmc0: new high speed SDHC card at address b368
[    6.334686] mmcblk0: mmc0:b368 USD   3.75 GiB 
[    6.347686]  mmcblk0: p1 p2 p3
[   18.374359] initcall ip_auto_config+0x0/0xf70 returned -19 after 
11809741 use
cs
[   18.382141] calling  initialize_hashrnd+0x0/0x1c @ 1
[   18.387420] initcall initialize_hashrnd+0x0/0x1c returned 0 after 59 
usecs
[   18.397949] async_waiting @ 1
[   18.401184] async_continuing @ 1 after 119 usec
(hangs)




