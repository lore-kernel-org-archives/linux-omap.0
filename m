From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP4 panda gets stuck during reboot
Date: Wed, 5 Jan 2011 16:26:27 +0200
Message-ID: <20110105142627.GG2304@legolas.emea.dhcp.ti.com>
References: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
 <45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com>
 <20110105141814.GF2304@legolas.emea.dhcp.ti.com>
 <7f40d94c30aa807513e7cdbc097a5caf@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:45443 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176Ab1AEO0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 09:26:33 -0500
Received: by ewy8 with SMTP id 8so6961986ewy.31
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 06:26:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7f40d94c30aa807513e7cdbc097a5caf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, Jan 05, 2011 at 07:52:34PM +0530, Santosh Shilimkar wrote:
> > On Wed, Jan 05, 2011 at 07:44:31PM +0530, Santosh Shilimkar wrote:
> > > > What could it be ? Any more debugging I could do to help ?
> > > >
> > > This is known and seems to OMAP specific issue. Test patch and
> >
> > Doesn't look like omap-specific from patch description. Looks like
> > like
> > CPU1 is turned off and the instruction to flush PMD entry fails.
> > Could
> > it be that all ARM SMPs are affected ?
> >
> Thread is broken some how. There were more emails on this one...
> Russell confirmed that he don't see the issue on his A9 Versatile
> platform and no one else complained except OMAP.

I see...

> Copy pasting some last updates..

Just finished reading the thread. Quite a problem on our side :-(

-- 
balbi
