From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding braces
Date: Sat, 8 May 2010 23:26:33 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD4960@dlee03.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC2622733@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54777 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786Ab0EIE0i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 May 2010 00:26:38 -0400
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90EC2622733@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Uribe de Leon, Armando" <x0095078@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 451e9733672b7fd3879ec109f3c6b2ac55c21cf5 Mon Sep 17 00:00:00 2001
>From: Armando Uribe De Leon <x0095078@ti.com>
>Date: Thu, 8 Apr 2010 17:14:38 -0500
>Subject: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding braces
>
>This patch removes checkpatch errors due to misleading braces
>
>Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/mem.h |    8 ++++----
> drivers/dsp/bridge/dynload/cload.c         |    4 ++--
> drivers/dsp/bridge/pmgr/cmm.c              |    5 ++---
> drivers/dsp/bridge/pmgr/dbll.c             |    3 +--
> drivers/dsp/bridge/wmd/io_sm.c             |    3 +--
> drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |    6 ++----
> 6 files changed, 12 insertions(+), 17 deletions(-)
>

Pushed to dspbridge.

- omar
