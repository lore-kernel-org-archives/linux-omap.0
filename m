From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 4 Oct 2010 23:56:52 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD86@dbde02.ent.ti.com>
References: <20101002004821.GN3117@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
 <8762xi3sm1.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD4F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab0JDS07 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:26:59 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD4F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G, 
> Manjunath Kondaiah
> Sent: Monday, October 04, 2010 10:16 PM
> To: Kevin Hilman
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: RE: NOTE: hwmod changes merged to linux-omap master 
> for testing
> 
>  
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > Sent: Monday, October 04, 2010 8:36 PM
> > To: G, Manjunath Kondaiah
> > Cc: Tony Lindgren; linux-omap@vger.kernel.org
> > Subject: Re: NOTE: hwmod changes merged to linux-omap master for 
> > testing
> > 
> > "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> > 
> > > Hi Tony,
> > > With latest merges on master branch with commit ID:
> > > 0882b1455797b0a104978000a622c3f2412e7cf5 omap: READ 
> CAREFULLY: Fix 
> > > build after merging in hwmod support for testing
> > >
> > > Booting with zoom3 seems to be fine but observed issues
> > with omap4 blaze board. 
> > >
> > > Looks like multiple warning dumps and finally it crashes
> > after "Freeing init memory" with both NFS and ramdisk file systems.
> > >
> > > The complete bootlogs are available at:
> > > NFS bootlog:
> > > http://pastebin.com/nrWQ5FGG
> > 
> > In the future, it helps greatly if you state what defconfig you're 
> > using,
> 
> ok. I have used omap2plus_defconfig
> 

Since this is for linux-omap master, now we have only omap2plus_defconfig
for all omap2plus hence the reason for not mentioning defconfig.

-Manjunath
