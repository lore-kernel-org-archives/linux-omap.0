From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Moving board patches from DSS2 to linux-omap
Date: Sat, 13 Feb 2010 16:04:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A96DC2F@dbde02.ent.ti.com>
References: <1265884185.2433.239.camel@tubuntu.research.nokia.com>
	 <4B73EF0D.8080904@compulab.co.il>
	 <1265889888.2433.245.camel@tubuntu.research.nokia.com>
	 <20100211185253.GG21755@atomide.com>
 <1265971459.2433.285.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42846 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0BMKeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Feb 2010 05:34:21 -0500
In-Reply-To: <1265971459.2433.285.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ext Tony Lindgren <tony@atomide.com>
Cc: ext Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Friday, February 12, 2010 4:14 PM
> To: ext Tony Lindgren
> Cc: ext Mike Rapoport; Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Subject: Re: Moving board patches from DSS2 to linux-omap
> 
> On Thu, 2010-02-11 at 19:52 +0100, ext Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@nokia.com> [100211 03:59]:
> > > On Thu, 2010-02-11 at 12:50 +0100, ext Mike Rapoport wrote:
> > > > Tomi Valkeinen wrote:
> > > > > Hi,
> > > > >
> > > > > As discussed previously, board file changes in DSS2 tree
> cause conflicts
> > > > > with linux-omap easily. There are currently three board file
> patches in
> > > > > DSS2's for-next branch:
> > > > >
> > > > > 722a97e4594b2041bbf18d95a913ba6dfaca87f2 omap3: cm-t35: add
> DSS2 display support
> > > > > 7a56267e775e469c64521179ccc958c8bb661dbf OMAP: AM3517:
> Enable DSS2 for AM3517EVM board
> > > > > 40e4e67c6dabcb9897b6823cce2297d6c3e78bbd OMAP: Enable DSS2
> for OMAP3EVM board
> > > > >
> > > > > The problem here is of course that DSS2 tree may contain
> unmerged panel
> > > > > drivers, and those board file changes try to use these new
> panel
> > > > > drivers.
> >
> > OK, Tomi, can you please set up a banch against mainline -rc7 with
> > whatever board-*.c dss2 patches you want me to pull? I'll pull
> them
> > into omap-for-linus, and rebase omap for-next on those.
> 
> Here:
> 
> git://gitorious.org/linux-omap-dss2/linux.git for-tony
> 
> I removed the defconfig changes from the patches, and compile
> tested.
> I'll add the defconfig changes as separate patches in my tree, and
> I'll
> push them to Linus only after the board changes from Tony's tree
> have
> gone through.
> 
[Hiremath, Vaibhav] Tomi,

I have pulled in for-tony branch and validated it on OAMP3EVM (with omap3_defconfig) and AM3517EVM without any issues. 

Do you need any help here? Do you want me to separate defconfig patches for you?

Thanks,
Vaibhav

>  Tomi
> 

