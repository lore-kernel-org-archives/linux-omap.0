From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/6] ARM: OMAP4: Add PMU Support
Date: Thu, 10 May 2012 11:43:11 +0530
Message-ID: <CAMQu2gxhidccsWetL1rcgeW=77MJuNcfhfjs5v=uWaB8H8Hq0A@mail.gmail.com>
References: <1336599216-10826-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49395 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751891Ab2EJGNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:13:33 -0400
Received: by qadb33 with SMTP id b33so78272qad.2
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:13:31 -0700 (PDT)
In-Reply-To: <1336599216-10826-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Jon,
On Thu, May 10, 2012 at 3:03 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> From: Jon Hunter <jon-hunter@ti.com>
>
> This series adds PMU support for OMAP4 devices. This is based upon Will Deacons
> series [1]. This series attempts to fix the management of the EMU power domain
> so that PMU can be enabled at runtime and low-power states are not prevented
> when PMU is not in-use. The fix is based upon inputs from Benoit, Paul and
> Kevin [2].
>
> This series is based upon the latest linux-omap master branch from Tony and has
> been tested on a OMAP4460 panda.
>
OMAP4460/70 devices too have dependency on the EMU domain so even though
there is a possibility to route PMU IRQ events bypassing the CTI, we
will still have
the same issue. So the fix is needed for all OMAP4 devices.

In OMAP5+ devices, PMU dependency with EMU domain is completely removed.

Regards
Santosh
