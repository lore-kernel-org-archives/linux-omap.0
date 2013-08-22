From: Kyle McMartin <kmcmarti@redhat.com>
Subject: Re: 3.11-rc1+ multiplatform kernel+dtb pandaboard issues
Date: Thu, 22 Aug 2013 10:00:34 -0400
Message-ID: <20130822140034.GL26531@redacted.bos.redhat.com>
References: <20130821154321.GA26531@redacted.bos.redhat.com>
 <20130821194143.GE26531@redacted.bos.redhat.com>
 <20130822063449.GO7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049Ab3HVOAw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Aug 2013 10:00:52 -0400
Content-Disposition: inline
In-Reply-To: <20130822063449.GO7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, Aug 21, 2013 at 11:34:50PM -0700, Tony Lindgren wrote:
> * Kyle McMartin <kmcmarti@redhat.com> [130821 12:48]:
> > On Wed, Aug 21, 2013 at 11:43:21AM -0400, Kyle McMartin wrote:
> > > I've suspected there might be a config issue, as omap2_defconfig
> > > works alright, as does booting a uImage with an appended
> > > omap4-panda.dtb, but there's no love with a zImage + initrd + dtb
> > > (or even just zImage without initrd + dtb.)
> > > 
> > 
> > after some further investigation, something odd is going on... turns
> > out things have been working (at least until initrd time, but that's
> > another story) fine but none of the bootargs have made it into the
> > kernel, so console= was unset and no messages came out.
> 
> Hmm I've seen that with extra quotes around the u-boot bootargs line.
> But if things work OK with omap2plus_defconfig, then it sounds that
> something gets trashed with your .config options. Care to post your
> .config file somewhere?
> 

Sure, CONFIG_CMDLINE is "" for us...

http://kyle.fedorapeople.org/config-3.11.0-0.rc6.git0.1.fc20.armv7hl

--Kyle
