From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/3] DSPBRIDGE: Remove chnl_sm.h and tiomap_sm.c
Date: Tue, 23 Mar 2010 12:34:02 -0500
Message-ID: <4BA8FB8A.8060606@ti.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18E3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47184 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422Ab0CWReH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 13:34:07 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA7C18E3@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On 2/12/2010 8:04 PM, Guzman Lugo, Fernando wrote:
>  From d287e11cdb126f2c9b4be8d6d6f958ffdf7ff716 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Fri, 22 Jan 2010 21:46:42 -0600
> Subject: [PATCH] DSPBRIDGE: Remove chnl_sm.h and tiomap_sm.c
>
> Because of mailbox migration all the functions in tiomap_sm.c except
> one and their prototypes in chnl_sm.h are not needed anymore,
> so that function was changed to tiomap_io.c and changed the name
> to remove camelcasing
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/chnl_sm.h |  154 ------------------------
>   drivers/dsp/bridge/Makefile                    |    2 +-
>   drivers/dsp/bridge/wmd/_tiomap.h               |   18 +++
>   drivers/dsp/bridge/wmd/io_sm.c                 |   13 +-
>   drivers/dsp/bridge/wmd/tiomap3430.c            |    3 +-
>   drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   13 +-
>   drivers/dsp/bridge/wmd/tiomap_io.c             |   71 +++++++++++
>   drivers/dsp/bridge/wmd/tiomap_sm.c             |  101 ----------------
>   8 files changed, 103 insertions(+), 272 deletions(-)
>   delete mode 100644 arch/arm/plat-omap/include/dspbridge/chnl_sm.h
>   delete mode 100644 drivers/dsp/bridge/wmd/tiomap_sm.c
>

Rebased and pushed to dspbridge.

- omar
