From: Casper Lyngesen Mogensen <clmogensen@grundfos.com>
Subject: RE: OMAP 3630 random crashes
Date: Tue, 1 Jul 2014 10:35:57 +0000
Message-ID: <1404210956640.67615@grundfos.com>
References: <1403254242990.39117@grundfos.com>
 <20140620091431.GA28884@atomide.com> <1403272840480.35753@grundfos.com>
 <CAK8F28=pF=gy10Lar35q2-s=f0TxNJFZ6XpdTFvHYankXtzH4Q@mail.gmail.com>
 <1403274413159.44797@grundfos.com> <1404135826925.10774@grundfos.com>
 <CAOf5uwn_+P5JkU7szHZNj74fqk7ArskiZnYn=eCeamPZ_dWS+g@mail.gmail.com>,<20140701075437.GM28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-db3lp0080.outbound.protection.outlook.com ([213.199.154.80]:8970
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751425AbaGAKf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 06:35:59 -0400
In-Reply-To: <20140701075437.GM28884@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Michael Trimarchi <michael@amarulasolutions.com>
Cc: Ash Charles <ash@gumstix.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

You are right. I used a different bootloader for the newer kernels, because of 
another build system and did not think about it.  The u-boot from github/gumstix 
sets the memory timings different than the u-boot directly from denx.de.

I switched to the gumstix-uboot and i can now allocate all the memory in the system
with all peripherals enabled, and i just get killed by the OOM a some point.

But thanks for the help so far, even though it was not a kernel issue :-)

Med venlig hilsen/Best regards

Casper Mogensen

________________________________________
From: Tony Lindgren <tony@atomide.com>
Sent: Tuesday, July 01, 2014 09:54
To: Michael Trimarchi
Cc: Casper Lyngesen Mogensen; Ash Charles; linux-omap@vger.kernel.org
Subject: Re: OMAP 3630 random crashes

* Michael Trimarchi <michael@amarulasolutions.com> [140630 06:49]:
>
> On Mon, Jun 30, 2014 at 3:43 PM, Casper Lyngesen Mogensen
> <clmogensen@grundfos.com> wrote:
> >
> > I got two new Overo AirStorm today, and they have same behavior. I tried disabling
> > the SMSC9xxx again and booted from MMC. This seems to make the backtrace a
> > little more consistent(Tried on both new and old). There is (almost) always something
> > about Alignment trap, the crash log itself differs every time. Also i get to allocate a lot
> > more memory before crash with these settings.
>
> What kernel version are you using?

We should have v3.15 working fine, but PM features are not merged
in util for v3.16.

I would try dding calls to omap_sdrc_init to pdata-quirks.c
the same way board-over.c is doing:

omap_sdrc_init(mt46h32m32lf6_sdrc_params,
                        mt46h32m32lf6_sdrc_params);

If the memory timings are not correctly set by the bootloader
that could explain the issues.

Regards,

Tony
