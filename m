From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/7] amp/omap: add a remoteproc driver
Date: Thu, 8 Dec 2011 09:57:43 +0200
Message-ID: <CAK=WgbZvH3eiouryKDenC_x0LdDcHFuumhfoeY4ueiwT5r0cxA@mail.gmail.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com> <1319536106-25802-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53766 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab1LHH6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 02:58:08 -0500
In-Reply-To: <1319536106-25802-5-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rusty Russell <rusty@rustcorp.com.au>, Russell King <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, Stephen Boyd <sboyd@codeaurora.org>

Hi Tony,

On Tue, Oct 25, 2011 at 11:48 AM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
> Add a remoteproc driver for OMAP4, so we can boot the dual-M3 "Ducati=
"
> and DSP subsystems.
>
> Use the omap_device_* API to control the hardware state, and utilize
> the OMAP mailbox to interrupt the remote processor when a new message
> is pending (the mailbox payload is used to tell it which virtqueue wa=
s
> the message placed in).
>
> Conversely, when an inbound mailbox message arrives, tell the remotep=
roc
> core which virtqueue is triggered.
>
> Later we will also use the mailbox payload to signal omap-specific
> events like remote crashes (which will be used to trigger remoteproc
> recovery) and power management transitions. At that point we will als=
o
> extend the remoteproc core to support this.
>
> Based on (but now quite far from) work done by Fernando Guzman Lugo
> <fernando.lugo@ti.com> and Hari Kanigeri <h-kanigeri2@ti.com>.
>
> Designed with Brian Swetland <swetland@google.com>.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Brian Swetland <swetland@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> ---
> =A0arch/arm/plat-omap/include/plat/remoteproc.h | =A0 56 ++++++
> =A0drivers/amp/remoteproc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
1 +++
> =A0drivers/amp/remoteproc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 +-
> =A0drivers/amp/remoteproc/omap_remoteproc.c =A0 =A0 | =A0248 ++++++++=
++++++++++++++++++
> =A0drivers/amp/remoteproc/omap_remoteproc.h =A0 =A0 | =A0 69 +++++++
> =A05 files changed, 397 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
> =A0create mode 100644 drivers/amp/remoteproc/omap_remoteproc.c
> =A0create mode 100644 drivers/amp/remoteproc/omap_remoteproc.h

I'm about to add this to linux-next (minus the 'amp' wording); can I
please have your Acked-by for this (at least for the plat-omap change) =
?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
