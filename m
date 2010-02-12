From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Moving board patches from DSS2 to linux-omap
Date: Fri, 12 Feb 2010 12:44:19 +0200
Message-ID: <1265971459.2433.285.camel@tubuntu.research.nokia.com>
References: <1265884185.2433.239.camel@tubuntu.research.nokia.com>
	 <4B73EF0D.8080904@compulab.co.il>
	 <1265889888.2433.245.camel@tubuntu.research.nokia.com>
	 <20100211185253.GG21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29239 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0BLKlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 05:41:36 -0500
In-Reply-To: <20100211185253.GG21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: ext Mike Rapoport <mike@compulab.co.il>, "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-02-11 at 19:52 +0100, ext Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [100211 03:59]:
> > On Thu, 2010-02-11 at 12:50 +0100, ext Mike Rapoport wrote:
> > > Tomi Valkeinen wrote:
> > > > Hi,
> > > > 
> > > > As discussed previously, board file changes in DSS2 tree cause conflicts
> > > > with linux-omap easily. There are currently three board file patches in
> > > > DSS2's for-next branch:
> > > > 
> > > > 722a97e4594b2041bbf18d95a913ba6dfaca87f2 omap3: cm-t35: add DSS2 display support
> > > > 7a56267e775e469c64521179ccc958c8bb661dbf OMAP: AM3517: Enable DSS2 for AM3517EVM board
> > > > 40e4e67c6dabcb9897b6823cce2297d6c3e78bbd OMAP: Enable DSS2 for OMAP3EVM board
> > > > 
> > > > The problem here is of course that DSS2 tree may contain unmerged panel
> > > > drivers, and those board file changes try to use these new panel
> > > > drivers.
> 
> OK, Tomi, can you please set up a banch against mainline -rc7 with
> whatever board-*.c dss2 patches you want me to pull? I'll pull them
> into omap-for-linus, and rebase omap for-next on those.

Here:

git://gitorious.org/linux-omap-dss2/linux.git for-tony

I removed the defconfig changes from the patches, and compile tested.
I'll add the defconfig changes as separate patches in my tree, and I'll
push them to Linus only after the board changes from Tony's tree have
gone through.

 Tomi


