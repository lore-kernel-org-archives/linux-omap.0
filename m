From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 0/2] DSPBRIDGE: 128 bytes alignment check
Date: Mon, 5 Apr 2010 21:49:33 -0500
Message-ID: <4BBAA13D.1060806@ti.com>
References: <1269637348-20608-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55717 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757169Ab0DFCte (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Apr 2010 22:49:34 -0400
In-Reply-To: <1269637348-20608-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 3/26/2010 4:02 PM, Ramirez Luna, Omar wrote:
> Technical info:
> https://omapzoom.org/gf/download/docmanfileversion/52/985/DSP_cache.pdf
>
> This set of patches introduces the 128 byte alignment check,
> needed to avoid corruption if the dsp is meant to write to
> boundary portions of an unaligned chunk of memory.
>
> The second patch uses a field composed of 2 bits to distinguish
> if the mapped chunk is readable/writeable, so the check can be
> performed on w/rw chunks of memory.
>
> Omar Ramirez Luna (2):
>    DSPBRIDGE: add checking 128 byte alignment for dsp cache line size
>    DSPBRIDGE: Distinguish between read or write buffers
>
>   arch/arm/plat-omap/include/dspbridge/dbdefs.h |    7 ++++++-
>   drivers/dsp/bridge/Kconfig                    |   14 ++++++++++++++
>   drivers/dsp/bridge/rmgr/proc.c                |   19 +++++++++++++++++++
>   drivers/dsp/bridge/wmd/tiomap3430.c           |    4 ++--
>   4 files changed, 41 insertions(+), 3 deletions(-)
>

Pushed to dspbridge.

- omar
