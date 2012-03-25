From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: OMAP and arm-soc's for-next branch
Date: Sun, 25 Mar 2012 10:19:27 +0000
Message-ID: <201203251019.27440.arnd@arndb.de>
References: <20120324122256.GA5611@n2100.arm.linux.org.uk> <201203241814.43002.arnd@arndb.de> <20120325075608.GB22608@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49661 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab2CYKTk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Mar 2012 06:19:40 -0400
In-Reply-To: <20120325075608.GB22608@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Sunday 25 March 2012, Russell King - ARM Linux wrote:
> On Sat, Mar 24, 2012 at 06:14:42PM +0000, Arnd Bergmann wrote:
> > On Saturday 24 March 2012, Russell King - ARM Linux wrote:
> > I had already pulled the omap_dss2 branch from Tomi into the next/cleanup
> > branch of arm-soc, in order to resolve a bunch of merge conflicts that we
> > discussed earlier.
> 
> I don't see the commit which Tony talked about - dc7e57fa (OMAPDSS:
> register dss drivers in module init) in last night's arm-soc for-next
> branch.  So, the only reason the autobuilds are able to boot is because
> I'm manually reverting 3ec2decb.
> 

Sorry, it seems I pulled the wrong subset. I've updated the omap/cleanup branch
with all of the fbdev updates now, which includes the commit you mentioned here.

Hope I got it right this time.

Sorry for the repeated screwups on this.

	Arnd
