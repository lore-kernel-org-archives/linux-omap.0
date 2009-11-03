From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Restart after 4 min of operation?
Date: Wed, 4 Nov 2009 00:10:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C8629E@dbde02.ent.ti.com>
References: <4AEFA4EE.40308@billgatliff.com>
 <4AF01901.2050100@mlbassoc.com>,<4AF06CBA.3040609@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C8629B@dbde02.ent.ti.com>,<4AF07876.4050602@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41314 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbZKCSoQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 13:44:16 -0500
In-Reply-To: <4AF07876.4050602@billgatliff.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Bill Gatliff wrote:
> Gadiyar, Anand wrote:
> > I suspect a watchdog timer of some kind, but I haven't got a clue which one.
> >
> 
> Turns out I had disabled watchdog timer support in my kernel.
> Re-enabling it seems to have addressed the problem--- the system has run
> for more than 5 minutes now.  :)
> 
> Apparently, the default for the OMAP watchdog timer is "armed" at
> reset?  Interesting.
> 
> 

Just read a little on the MPU watchdog timer. It looks like the default values would
have caused a reset after ~10s. So if your board is rebooting after 4 minutes,
maybe the bootloader is turning it on?

I've left a board on in the bootloader for hours without seeing a reboot, so either
the bootloader I was using disables the watchdog, or it's not armed at reset.

- Anand