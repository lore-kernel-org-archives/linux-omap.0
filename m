From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: Remove un-used enums
Date: Tue, 26 Jan 2010 19:31:23 -0600
Message-ID: <4B5F976B.8090907@ti.com>
References: <1264221870-11178-1-git-send-email-omar.ramirez@ti.com> <1264221870-11178-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47227 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab0A0Bb2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 20:31:28 -0500
In-Reply-To: <1264221870-11178-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Hebbar, Shivananda" <x0hebbar@ti.com>

On 1/22/2010 10:44 PM, Ramirez Luna, Omar wrote:
> From: Shivananda Hebbar<x0hebbar@ti.com>
>
> This patch removes un-used enum definitions from bridge.
>
> Signed-off-by: Shivananda Hebbar<x0hebbar@ti.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/cmmdefs.h |    8 --------
>   drivers/dsp/bridge/hw/IPIAccInt.h              |   15 ---------------
>   drivers/dsp/bridge/wmd/_tiomap.h               |   15 ---------------
>   3 files changed, 0 insertions(+), 38 deletions(-)
>

Pushed to dspbridge.

- omar
