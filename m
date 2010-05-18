From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Tue, 18 May 2010 11:46:42 +0300 (EEST)
Message-ID: <20100518.114642.35020415.Hiroshi.DOYU@nokia.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39246 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab0ERIrC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 04:47:02 -0400
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Fri, 14 May 2010 17:01:33 +0200

> Hi,
> 
> The main purpose of this patch series is to be able to compile mach platform
> data as built-in. Otherwise, client modules such as bridgedriver will load the
> platform code, but not the mach code when mailbox is built as a module.

I think that this is the *udev* responsibility. The udev should take
care of loading mailbox_mach.ko since the mailbox platform device was
registered by devices.ko at bootup. devices.ko is built in earlier
than dspbridge.ko, so the mailbox platform device is registered
earlier than the dsp device, "C6410". this registration ordering
should take care of the dependency if the udevd works correctly.

> Unfortunately, there's no easy way to do that since plat and mach code are
> deepely interrelated. So the first patches try to separate the mailbox
> registering through a defined omap_mbox_platform_data.
> 
> Also, it's worth noting that mailboxes are not a one-to-one mapping to
> resources; that is, some resources belong to multiple mboxes. So it's best to
> think of mailboxes as fake devices. That is why custom platform_data
> is required.

Actually there were logical mailbox devices/instances implemented, but
it was broken partially when dropping mailbox class support by
accident(*1). This is the reason whey omap_mbox struct has unused dev
pointer now. At that time, the sysfs interface was not necessary but
the device creation itself should not have been removed. I'll get this
code back again soon.

The role of each modules were/should be:

  - devices.ko:		a platform device, based on its resource.
  - mailbox_mach.ko:	a platform driver to register multiple logical mboxes/devices.
  - mailbox.ko:		a kind of framework which holds multiple logical mboxes/devices.

The sysfs structure is like below:

  ~# tree -d -L 2 /sys/devices/platform/omap2-mailbox/
  /sys/devices/platform/omap2-mailbox/
  |-- driver -> ../../../bus/platform/drivers/omap2-mailbox
  |-- mbox
  |   |-- dsp      <- they are each instances of logical mailbox.
  |   |-- ducati
  |   |-- iva2
  |   |-- mbox01
  |   |-- mbox02
  |   |-- mbox03
  |   `-- tesla
  |-- power
  `-- subsystem -> ../../../bus/platform

The platform device omap2-mailbox accomodatess logical mboxes.

> 
> Finally, a bunch of cleaning up is done in the very first patches, specially for
> OMAP1.

Most of the cleanups are quite ok.

Would it be possible to rebase them on the top of my coming patch to
get back logical device entry?

Sorry for the late reply, it took some time to recall my bad memory...

*1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19546.html

> 
> The initial RFC included comments from Felipe Balbi, and this proposal includes
> comments from Tony Lindgren.
> 
> v2:
>  * Rebased on top of Hiroshi's v2.6.34-rc7.mailbox
>  * A bit more extra cleanups
> 
> v1 was tested on OMAP3 (beagleboard), and compiled-tested for OMAP1.
> v2 was compile-tested for OMAP3 and 1.
> 
> Felipe Contreras (17):
>   omap: mailbox: trivial whitespace cleanups
>   omap: mailbox: trivial cleanups
>   omap: mailbox: reorganize structures
>   omap: mailbox: 2420 should be detected at run-time
>   omap: mailbox: use correct config for omap1
>   omap: mailbox: update omap1 probing
>   omap: mailbox: reorganize registering
>   omap: mailbox: only compile for configured archs
>   omap: mailbox: reorganize omap platform_device
>   omap: mailbox: move more stuff to omap_mbox_init()
>   omap: mailbox: trivial sync between omap1 and 2
>   omap: mailbox: split platform driver
>   omap: mailbox: always built-in platform data
>   omap: mailbox: reorganize headers
>   omap: mailbox: don't export unecessary symbols
>   omap: mailbox: mark some resources as __initdata
>   omap: mailbox: don't export register/unregister
> 
>  arch/arm/mach-omap1/Makefile              |    6 +-
>  arch/arm/mach-omap1/devices.c             |   40 -----
>  arch/arm/mach-omap1/mailbox.c             |  118 ++++++++------
>  arch/arm/mach-omap2/Makefile              |    5 +-
>  arch/arm/mach-omap2/devices.c             |   92 -----------
>  arch/arm/mach-omap2/mailbox.c             |  254 ++++++++++++++++-------------
>  arch/arm/plat-omap/include/plat/mailbox.h |   10 +-
>  arch/arm/plat-omap/mailbox.c              |   89 +++++++---
>  8 files changed, 290 insertions(+), 324 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
