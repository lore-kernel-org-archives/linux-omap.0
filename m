From: Kyle McMartin <kmcmarti@redhat.com>
Subject: Re: 3.11-rc1+ multiplatform kernel+dtb pandaboard issues
Date: Thu, 22 Aug 2013 13:19:17 -0400
Message-ID: <20130822171917.GN26531@redacted.bos.redhat.com>
References: <20130821154321.GA26531@redacted.bos.redhat.com>
 <20130821194143.GE26531@redacted.bos.redhat.com>
 <20130822002558.GA9933@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2953 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784Ab3HVRTV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Aug 2013 13:19:21 -0400
Content-Disposition: inline
In-Reply-To: <20130822002558.GA9933@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

On Thu, Aug 22, 2013 at 02:25:59AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Aug 21, 2013 at 03:41:43PM -0400, Kyle McMartin wrote:
> > On Wed, Aug 21, 2013 at 11:43:21AM -0400, Kyle McMartin wrote:
> > > I've suspected there might be a config issue, as omap2_defconfig
> > > works alright, as does booting a uImage with an appended
> > > omap4-panda.dtb, but there's no love with a zImage + initrd + dtb
> > > (or even just zImage without initrd + dtb.)
> > > 
> > 
> > after some further investigation, something odd is going on... turns
> > out things have been working (at least until initrd time, but that's
> > another story)
> 
> The initrd problem may be the same error I got, when I tried to boot
> an OMAP DT kernel with an initrd file (I had no problems with kernel
> arguments):
> 

Definitely looks similar... I don't even get that far though. Spooky.
Something definitely seems wonky.

--Kyle
