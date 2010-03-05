From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
Date: Fri, 05 Mar 2010 10:48:57 +0200
Message-ID: <1267778937.4866.9.camel@chotu.research.nokia.com>
References: <B852767254C5C94EBB1040EE0EFA060091FBE92D@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43268 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab0CEIt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 03:49:28 -0500
In-Reply-To: <B852767254C5C94EBB1040EE0EFA060091FBE92D@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

Hi Ernesto,

On Fri, 2010-03-05 at 01:39 +0100, ext Ramos Falcon, Ernesto wrote:
> From 1d7f5d634176be558d5a60e26ee2bdeddffd7d3b Mon Sep 17 00:00:00 2001
> From: Cris Jansson <cjansson@ti.com>
> Date: Thu, 25 Feb 2010 11:38:23 -0600
> Subject: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
> 
> These changes allow for DSP task information to be printed
> by the MPU dspbridge when DSP MMU fault ocurrs.
> 
> Signed-off-by: Cris Jansson <cjansson@ti.com>
> [change to open soutce coding style]

source

> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/dbll.h  |    3 +
>  arch/arm/plat-omap/include/dspbridge/gh.h    |    3 +
>  arch/arm/plat-omap/include/dspbridge/io_sm.h |    5 +
>  arch/arm/plat-omap/include/dspbridge/nldr.h  |    3 +
>  arch/arm/plat-omap/include/dspbridge/node.h  |   12 +
>  drivers/dsp/bridge/Makefile                  |    1 +
>  drivers/dsp/bridge/gen/gh.c                  |   22 ++
>  drivers/dsp/bridge/pmgr/dbll.c               |   62 +++
>  drivers/dsp/bridge/rmgr/nldr.c               |   71 ++++
>  drivers/dsp/bridge/rmgr/node.c               |   31 ++
>  drivers/dsp/bridge/wmd/io_sm.c               |  515 ++++++++++++++++++++------
>  drivers/dsp/bridge/wmd/ue_deh.c              |   67 +++-
>  12 files changed, 680 insertions(+), 115 deletions(-)

<Snip>

> +
> +/*
> + *     ======== node_find_addr ========
> + *     Purpose:
> + *             Find the closest symbol to the given address.
> + *     Parameters:
> + *
> + */

Since you are adhering to open source coding style why not use linux
kernel commenting style at all places in patch ;)

Cheers,
Ameya.

