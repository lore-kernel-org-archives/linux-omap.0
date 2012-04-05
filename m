From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
Date: Thu, 5 Apr 2012 16:54:03 +0530
Message-ID: <CAMrsUd+_coW7ebuN_o=yZbbSVKnkx5R6=yHjUEUc0EcQGtgSRQ@mail.gmail.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55892 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962Ab2DELYZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Apr 2012 07:24:25 -0400
Received: by pbcun4 with SMTP id un4so1472696pbc.36
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 04:24:23 -0700 (PDT)
In-Reply-To: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

On Wed, Mar 21, 2012 at 3:54 PM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> Based on Linux-OMAP tree uart branch.
> (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> remotes/origin/uart)
>
> * Removes the cpu checks wherever possible and use version reg
> =A0for populating features and errata's
> * enable tx wakeup available in wer reg for applicable
> =A0module revision's
>
> Govindraj.R (3):
> =A0OMAP2+: UART: Remove cpu checks for populating errata flags
> =A0OMAP2+: UART: enable tx wakeup bit for wer reg
> =A0OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24x=
x
>
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 13 +----
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A08 +++-
> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
71 ++++++++++++++++++++++++-
> =A03 files changed, 78 insertions(+), 14 deletions(-)

Alan / Greg,

With you ack on tty parts can this series be upstreamed from
omap tree ?


Tony,

Can you take these series into your uart fixes branch for 3.4-rc
(Let me know if you need a pull request with patches based on
linux-omap tree uart branch)

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
