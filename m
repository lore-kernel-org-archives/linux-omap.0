From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Tue, 25 Jun 2013 18:20:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49967 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab3FYSUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 14:20:52 -0400
In-Reply-To: <20130625160243.GE22312@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tom Rini <trini@ti.com>, hvaibhav@ti.com, khilman@ti.com

+ Vaibhav and Kevin

Hi,

On Tue, 25 Jun 2013, Felipe Balbi wrote:

> On Mon, Jun 17, 2013 at 05:23:17AM +0000, Paul Walmsley wrote:
> > Boot to userspace:
> >     FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt
> 
> Paul, we have at least 2 different folks who can't reproduce your bone
> and bone black boot to userspace failures. I wonder how you're trying to
> boot them.
> 
> Care to share your test scripts ?

Sure... the methodology is completely open and has been posted in the 
online logs since the first test cycle.  (For some reason, almost no one 
clicks through the test directory trees that I post online.  Is this a 
documentation issue?  What can we do to make it easier for people to 
explore this?)

Anyway, for BeagleBone white, here's the last working test log, from 3.7:

http://www.pwsan.com/omap/testlogs/test_v3.7/20121211094536/boot/am335xbone/am335xbone_log.txt

The concatenated kernel and DTB, along with the Kconfig used to build, are
here:

http://www.pwsan.com/omap/testlogs/test_v3.7/20121211094536/build/am33xx_only/

The boot broke immediately afterwards with v3.8-rc1 and has never worked 
since:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/boot/am335xbone/

You can find all of the archived testlogs here:

http://www.pwsan.com/omap/testlogs/

You'll probably only be interested in the ones that start with "test_v3.".

...

As for BeagleBone Black, here's the latest non-booting log:

http://www.pwsan.com/omap/testlogs/test_v3.10-rc6/20130616211951/boot/am335xbonelt/am335x-bone/am335xbonelt_log.txt

This has never booted on mainline for me.  The closest I got was with the 
ti-linux-3.8.y tree on Vaibhav's github account, which booted with 
the 'am335x-boneblack.dtb' built from the same tree.  Mainline didn't boot 
with either the am335x-bone.dtb or Vaibhav's am335x-boneblack.dtb, but 
since it booted on 3.8.y with am335x-boneblack.dtb, I've kept that 
around for the mainline boot tests (as you can see from the logs).

There's nothing exotic about the kernel used here, it's a pure 
omap2plus_defconfig zImage.

The bootloader and DTB used are here (booted via serial from the boot 
ROM):

http://www.pwsan.com/tmp/boneblack-20130625/

Please let me know if you need more binaries shared from the test runs!

...

Am certainly open to the idea that there's something wrong with the way 
that I'm booting either of these.  But AFAIK no one's been able to 
identify exactly what it could be.  I haven't had the time recently to 
spend hours going through the various permutations, given all the other 
breakage :-(  BeagleBone-white has the additional complication that it is 
not easy to automate, due to the way that power is delivered to the board, 
so there is an extra dimension of difficulty there.

> Also, if you could share the entire thing, we will add your scripts to
> our nightly tests as to try and avoid future regressions.

It would be great to have TI folks running those tests, or something 
similar to them!  An early version of the test system has been shared with 
a handful of folks, but it needs to be cleaned up further before broader 
release.


- Paul
