From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
Date: Wed, 21 Mar 2012 07:28:46 -0700
Message-ID: <87limurpsx.fsf@ti.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:51354 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031219Ab2CUO2q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 10:28:46 -0400
Received: by mail-yw0-f44.google.com with SMTP id k25so1239985yhk.17
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 07:28:45 -0700 (PDT)
In-Reply-To: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 21 Mar 2012 15:54:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> Based on Linux-OMAP tree uart branch.
> (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> remotes/origin/uart)
>
> * Removes the cpu checks wherever possible and use version reg
>   for populating features and errata's
> * enable tx wakeup available in wer reg for applicable
>   module revision's

As this affects multiple SoCs, please report what SoCs it was tested on
as well.

Thanks,

Kevin

> Govindraj.R (3):
>   OMAP2+: UART: Remove cpu checks for populating errata flags
>   OMAP2+: UART: enable tx wakeup bit for wer reg
>   OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
>
>  arch/arm/mach-omap2/serial.c                  |   13 +----
>  arch/arm/plat-omap/include/plat/omap-serial.h |    8 +++-
>  drivers/tty/serial/omap-serial.c              |   71 ++++++++++++++++++++++++-
>  3 files changed, 78 insertions(+), 14 deletions(-)
