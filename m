From: Matt Porter <mporter@ti.com>
Subject: Re: defconfig for panda
Date: Fri, 20 Apr 2012 12:01:26 -0400
Message-ID: <20120420160126.GA21441@beef>
References: <1F91D012-8308-45BB-83AD-90E52D472AC2@kernel.crashing.org>
 <20120330184859.GB8240@atomide.com>
 <B05E7CFB-E2F3-426C-AAA8-622D715DB86A@kernel.crashing.org>
 <20120330213930.GC8240@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62263 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032Ab2DTQBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 12:01:20 -0400
Received: by iagz16 with SMTP id z16so13564916iag.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 09:01:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120330213930.GC8240@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kumar Gala <galak@kernel.crashing.org>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Fri, Mar 30, 2012 at 02:39:32PM -0700, Tony Lindgren wrote:
> * Kumar Gala <galak@kernel.crashing.org> [120330 14:14]:
> > 
> > On Mar 30, 2012, at 1:48 PM, Tony Lindgren wrote:
> > 
> > > Hi,
> > > 
> > > * Kumar Gala <galak@kernel.crashing.org> [120329 12:24]:
> > >> As I'm new to the OMAP community this might be a stupid question but trying to just build and run a stock v3.3 kernel on a pandaboard.  In doing so it seems as if some basic drivers are not enabled in omap2plus_defconfig for the board.  I'm trying to figure out if this is normal for some reason or just an oversight.
> > >> 
> > >> For example, USB and USB ethernet (SMC95xx).  I notice the linaro kernel tree introduces an omap4_defconfig, so just wondering should I send patches to omap2plus_defconfig or what?
> > > 
> > > We can add those to omap2plus_defconfig for sure, but let's have
> > > them added as modules. Then distros can use that easily in a
> > > standard way using initramfs-tools etc.
> > > 
> > > Let's not change the drivers that are currently built in if they're
> > > needed for mounting mmc or nfsroot. Those can be changed later on.
> > 
> > I'll work up a patch, however I was doing this as I was trying to get NFS root working and thus would need USB + USB ethernet compiled in and not as modules for panda.  Is that ok?
> 
> Maybe, let's take a look how much bigger the kernel becomes.
> Also we need to check if the same EHCI configuration works
> for omap3/4.

FWIW, the same EHCI + SMSC95xx config is used for Beagle xM for
nfsroot. First thing I enable on any builds.

-Matt
