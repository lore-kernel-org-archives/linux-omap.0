From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM3517 fails to boot 3.16-rc5 device tree kernel
Date: Mon, 21 Jul 2014 00:09:13 -0700
Message-ID: <20140721070913.GN18374@atomide.com>
References: <20140717234037.GA9660@sysresccd>
 <20140718063806.GK18374@atomide.com>
 <CAO5Z=i1WdcrwWP2F6XZimUD5ts66AsV3RrvA31g71aUJewbNJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14901 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbaGUHKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 03:10:37 -0400
Content-Disposition: inline
In-Reply-To: <CAO5Z=i1WdcrwWP2F6XZimUD5ts66AsV3RrvA31g71aUJewbNJA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@emacinc.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, paul@pwsan.com

* Michael Welling <mwelling@emacinc.com> [140718 07:42]:
> On Fri, Jul 18, 2014 at 1:38 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hmm maybe double check your're booting device tree based kernel
> > instead of legacy machine ID based kernel? The legacy booting should
> > still work just fine and no changes has been made to it, but it will
> > get removed shortly.
>
> I downloaded the version from the test results and it did boot.

OK that's good to hear.

> These are combining the uImage and dtb. How do you accomplish this?

You need to make sure you have the appended DTB support enabled like
we do in omap2plus_defconfig:

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y

Then just cat zImage board.dtb > /tmp/zImage-dtba and run
mkimage to convert it to a uImage:

$ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
	-n "Linux" -d /tmp/zImage-dtba /tmp/uImage

Regards,

Tony
