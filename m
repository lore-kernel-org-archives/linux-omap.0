From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.11-rc1+ multiplatform kernel+dtb pandaboard issues
Date: Mon, 26 Aug 2013 07:20:23 -0700
Message-ID: <20130826142023.GI7656@atomide.com>
References: <20130821154321.GA26531@redacted.bos.redhat.com>
 <20130821194143.GE26531@redacted.bos.redhat.com>
 <20130822063449.GO7656@atomide.com>
 <20130822140034.GL26531@redacted.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31077 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752002Ab3HZOU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 10:20:26 -0400
Content-Disposition: inline
In-Reply-To: <20130822140034.GL26531@redacted.bos.redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyle McMartin <kmcmarti@redhat.com>
Cc: linux-omap@vger.kernel.org

* Kyle McMartin <kmcmarti@redhat.com> [130822 07:08]:
> On Wed, Aug 21, 2013 at 11:34:50PM -0700, Tony Lindgren wrote:
> > * Kyle McMartin <kmcmarti@redhat.com> [130821 12:48]:
> > > On Wed, Aug 21, 2013 at 11:43:21AM -0400, Kyle McMartin wrote:
> > > > I've suspected there might be a config issue, as omap2_defconfig
> > > > works alright, as does booting a uImage with an appended
> > > > omap4-panda.dtb, but there's no love with a zImage + initrd + dtb
> > > > (or even just zImage without initrd + dtb.)
> > > > 
> > > 
> > > after some further investigation, something odd is going on... turns
> > > out things have been working (at least until initrd time, but that's
> > > another story) fine but none of the bootargs have made it into the
> > > kernel, so console= was unset and no messages came out.
> > 
> > Hmm I've seen that with extra quotes around the u-boot bootargs line.
> > But if things work OK with omap2plus_defconfig, then it sounds that
> > something gets trashed with your .config options. Care to post your
> > .config file somewhere?
> > 
> 
> Sure, CONFIG_CMDLINE is "" for us...
> 
> http://kyle.fedorapeople.org/config-3.11.0-0.rc6.git0.1.fc20.armv7hl

Tried this on my 4430 SDP with the current tip of linux-omap tree
at -rc6, had to disable FTRACE and ARCH_ZYNQ to compile.

I can confirm that earlyprintk works, but no output from the
serial console. Looking at the console output, looks like serial-omap
probe is deferred because of no pinctrl driver. So having:

CONFIG_PINCTRL_SINGLE=y

fixes the issue at least for me booting to the point where it tries
to mount root. It seems to be set to module in your .config.

Note that there's still that one bug where earlyprintk does not properly
work with serial-omap because of the idling of the device.. But that's a
separate issue :)

Regards,

Tony
