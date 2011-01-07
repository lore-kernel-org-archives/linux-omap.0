From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Fri, 7 Jan 2011 18:55:52 +0000
Message-ID: <20110107185552.GU1198@n2100.arm.linux.org.uk>
References: <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk> <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com> <20110107142432.GO1198@n2100.arm.linux.org.uk> <c71399f20609c539b8c335344963253f@mail.gmail.com> <20110107162429.GS1198@n2100.arm.linux.org.uk> <bd43a9ab39b53bfad963a471204e7b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49401 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab1AGS4B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 13:56:01 -0500
Content-Disposition: inline
In-Reply-To: <bd43a9ab39b53bfad963a471204e7b92@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Jan 07, 2011 at 11:59:07PM +0530, Santosh Shilimkar wrote:
> > ks8851 spi1.0: message enable is 0
> > ks8851 spi1.0: eth0: revision 0, MAC 1a:6a:b1:02:1d:90, IRQ 194
> > IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.0.144
> > IP-Config: Complete:
> >      device=eth0, addr=192.168.0.144, mask=255.255.255.0,
> > gw=192.168.0.1,
> >      host=192.168.0.144, domain=arm.linux.org.uk, nis-domain=(none),
> >      bootserver=0.0.0.0, rootserver=0.0.0.0, rootpath=
> >
> > but the board doesn't respond to that IP address.  Meanwhile the
> > DHCP
> > server shows:
> >
> > 	DHCPDISCOVER from 1a:6a:b1:02:1d:90 via eth0
> >
> > in its log, and the ethernet address appears to be random for each
> > boot.
> > Obviously, as I can't log into the board via any means, it's nigh on
> > impossible to work out what's actually going on.
> 
> DHCP seems to work for me without any issues.

The board now has an ethernet address of 1E:89:8E:DA:80:7C - it
seems to be intentionally random which isn't particularly nice.
At least it's intentionally random and not some undefined region of
memory being poked in there...
