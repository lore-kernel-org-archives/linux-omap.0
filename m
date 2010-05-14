From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Fri, 14 May 2010 18:09:30 +0300
Message-ID: <AANLkTildHTovAq6DZa2nPgYwX3BHsHuvM9oKGFssFH6-@mail.gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:55839 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab0ENPJv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:09:51 -0400
Received: by yxe29 with SMTP id 29so1019319yxe.4
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 08:09:50 -0700 (PDT)
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

Hi Felipe,

On Fri, May 14, 2010 at 6:01 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> The main purpose of this patch series is to be able to compile mach p=
latform
> data as built-in. Otherwise, client modules such as bridgedriver will=
 load the
> platform code, but not the mach code when mailbox is built as a modul=
e.
>
> Unfortunately, there's no easy way to do that since plat and mach cod=
e are
> deepely interrelated. So the first patches try to separate the mailbo=
x
> registering through a defined omap_mbox_platform_data.


Have you considered converting mailbox to hwmod + omap_device ?


Thanks,
Ohad.

>
> Also, it's worth noting that mailboxes are not a one-to-one mapping t=
o
> resources; that is, some resources belong to multiple mboxes. So it's=
 best to
> think of mailboxes as fake devices. That is why custom platform_data =
is required.
>
> Finally, a bunch of cleaning up is done in the very first patches, sp=
ecially for
> OMAP1.
>
> The initial RFC included comments from Felipe Balbi, and this proposa=
l includes
> comments from Tony Lindgren.
>
> v2:
> =A0* Rebased on top of Hiroshi's v2.6.34-rc7.mailbox
> =A0* A bit more extra cleanups
>
> v1 was tested on OMAP3 (beagleboard), and compiled-tested for OMAP1.
> v2 was compile-tested for OMAP3 and 1.
>
> Felipe Contreras (17):
> =A0omap: mailbox: trivial whitespace cleanups
> =A0omap: mailbox: trivial cleanups
> =A0omap: mailbox: reorganize structures
> =A0omap: mailbox: 2420 should be detected at run-time
> =A0omap: mailbox: use correct config for omap1
> =A0omap: mailbox: update omap1 probing
> =A0omap: mailbox: reorganize registering
> =A0omap: mailbox: only compile for configured archs
> =A0omap: mailbox: reorganize omap platform_device
> =A0omap: mailbox: move more stuff to omap_mbox_init()
> =A0omap: mailbox: trivial sync between omap1 and 2
> =A0omap: mailbox: split platform driver
> =A0omap: mailbox: always built-in platform data
> =A0omap: mailbox: reorganize headers
> =A0omap: mailbox: don't export unecessary symbols
> =A0omap: mailbox: mark some resources as __initdata
> =A0omap: mailbox: don't export register/unregister
>
> =A0arch/arm/mach-omap1/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06=
 +-
> =A0arch/arm/mach-omap1/devices.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 40 ---=
--
> =A0arch/arm/mach-omap1/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0118 +++=
+++++------
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05=
 +-
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 92 ---=
--------
> =A0arch/arm/mach-omap2/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0254 +++=
+++++++++++++-------------
> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 10 +-
> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 89 +=
++++++---
> =A08 files changed, 290 insertions(+), 324 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
