From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Tue, 01 Mar 2011 15:23:15 +0100
Message-ID: <1298989395.6461.2.camel@maggie>
References: <1298925943.16391.19.camel@marge>
	 <20110301092057.GA2942@legolas.emea.dhcp.ti.com>
	 (sfid-20110301_102108_023001_FFFFFFFFACB50B7A)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:49211 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab1CAOXV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 09:23:21 -0500
In-Reply-To: <20110301092057.GA2942@legolas.emea.dhcp.ti.com> (sfid-20110301_102108_023001_FFFFFFFFACB50B7A)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Varadarajan Charulatha <charu@ti.com>

On Tue, 2011-03-01 at 11:20 +0200, Felipe Balbi wrote: 
> On Mon, Feb 28, 2011 at 09:45:43PM +0100, Michael Buesch wrote:
> > The n810 LCD does not work on the 2.6.38(-rc6) kernel
> > due to changes in the OMAP GPIO-hwmod code.
> > 
> > The hwmod code performs a soft-reset on the GPIO
> > module. The first GPIO module carries the MIPID
> > "nreset" line, which is toggled due to the hwmod soft reset.
> > This resets Blizzard and breaks it, because
> > it assumes the LCD was left in the state that the
> > bootloader initialized it to:
> 
> so that's the bug which needs to be fixed. Unfortunately I don't have
> any documentation available anymore. Maybe someone from Nokia would fix
> that ?
> 
> > I'm wondering if a better fix suitable for the mainline
> > kernel inclusion could be found.
> > Any ideas?
> 
> Don't depend on the bootloader :-)

Yeah that's the obvious fix, of course. However, it requires
deep knowledge of the device and/or hardware documentation. Both
of which I don't have.
The driver also doesn't seem to have a maintainer.

If someone can get me documentation, I'm willing to implement
the required bits to remove the bootloader dependency.

-- 
Greetings Michael.

