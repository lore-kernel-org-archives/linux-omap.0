From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 4 Oct 2010 22:16:21 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD4F@dbde02.ent.ti.com>
References: <20101002004821.GN3117@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
 <8762xi3sm1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47545 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab0JDQq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 12:46:29 -0400
In-Reply-To: <8762xi3sm1.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Monday, October 04, 2010 8:36 PM
> To: G, Manjunath Kondaiah
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: NOTE: hwmod changes merged to linux-omap master 
> for testing
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Hi Tony,
> > With latest merges on master branch with commit ID:
> > 0882b1455797b0a104978000a622c3f2412e7cf5 omap: READ CAREFULLY: Fix 
> > build after merging in hwmod support for testing
> >
> > Booting with zoom3 seems to be fine but observed issues 
> with omap4 blaze board. 
> >
> > Looks like multiple warning dumps and finally it crashes 
> after "Freeing init memory" with both NFS and ramdisk file systems.
> >
> > The complete bootlogs are available at:
> > NFS bootlog:
> > http://pastebin.com/nrWQ5FGG
> 
> In the future, it helps greatly if you state what defconfig 
> you're using, 

ok. I have used omap2plus_defconfig

> and specifically what you've changed from the 
> default defconfig.
No changes to defconfig

> 
> Looking at this log, you've enabled CPUidle in your config, 
> which is not
> (yet) supported for OMAP4 in mainline.

As I mentioned no changes to defconfig and it looks like cpu idle
is disabled and cpu idle wait is enabled in .config after running
make omap2plus_defconfig

$ cat arch/arm/configs/omap2plus_defconfig | grep "CPU_IDLE"
$
$ make omap2plus_defconfig
#
# configuration written to .config
#
$ cat .config | grep "CPU_IDLE"
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
# CONFIG_CPU_IDLE is not set
$

Even if I disable CPU_IDLE_WAIT manually, behaviour is same

-Manjunath
