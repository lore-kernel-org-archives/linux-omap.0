From: Tony Lindgren <tony@atomide.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Tue, 8 Apr 2008 20:08:57 +0000
Message-ID: <20080408200857.GB31071@atomide.com>
References: <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com> <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com> <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com> <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com> <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com> <47F7B240.2070901@gmail.com> <20080406132323.GA13033@bulgaria.corp.google.com> <20080407094715.72685822.jarkko.nikula@nokia.com> <20080407065109.GA16340@bulgaria.corp.google.com> <20080407101343.a20e36a8.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65477 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbYDHUJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 16:09:05 -0400
Content-Disposition: inline
In-Reply-To: <20080407101343.a20e36a8.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Brian Swetland <swetland@google.com>, Nishanth Menon <menon.nishanth@gmail.com>, Georges.Toth@gmail.com, linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080407 07:13]:
> On Sun, 6 Apr 2008 23:51:09 -0700
> "ext Brian Swetland" <swetland@google.com> wrote:
> 
> > Well I'm looking for two specific things:
> > 
> > - can I use wifi with a 2.6.23 or 2.6.24 kernel?  The proprietary
> > module part of the wifi driver did not work with > 2.6.21 kernels
> > when I tried (due to network stack structure changes by the look of
> > things).
> > 
> Most probably not I think. But worth to search the maemo developers
> mailing list are there any info about this.
> 
> > - can I get the battery to charge without proprietary, binary-only,
> >   non-redistributable userspace code?  It did not seem like that was
> >   the case a couple months ago.  Perhaps it's better now?
> > 
> This should work if you boot through the initfs as usual. E.g. I've
> run the Debian armel on N810 using up-to-date linux-omap.

I guess there are still some N800/N810 patches missing from
l-o tree.

Also, you probably need to patch N810 machine id to
5555 in arch/arm/tools/mach-types to boot..

Tony
