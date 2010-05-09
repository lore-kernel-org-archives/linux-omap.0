From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/5v2] DSPBRIDGE: Remove checkpatch warnings: 80 char
 lines
Date: Sat, 8 May 2010 23:28:44 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD4965@dlee03.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC26C7E43@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54926 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103Ab0EIE2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 May 2010 00:28:50 -0400
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90EC26C7E43@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Uribe de Leon, Armando" <x0095078@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From ff68a8b932f4a542d0ec464a40d9abce93327291 Mon Sep 17 00:00:00 2001
>From: Armando Uribe De Leon <x0095078@ti.com>
>Date: Mon, 19 Apr 2010 16:51:00 -0500
>Subject: [PATCH 2/5] DSPBRIDGE: Remove checkpatch warnings: 80 char lines
>
>This patch removes checkpatch warning regarding with
>lines exceeded 80 characters.
>
>Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/dev.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/wmdmsg.h |    3 +-
> drivers/dsp/bridge/pmgr/dev.c                 |    3 +-
> drivers/dsp/bridge/rmgr/node.c                |   67 ++++++++++--------------
> drivers/dsp/bridge/rmgr/pwr.c                 |    8 ++--
> drivers/dsp/bridge/wmd/chnl_sm.c              |    4 +-
> 6 files changed, 39 insertions(+), 48 deletions(-)
>

Pushed to dspbridge. The first version of this patch was not pushed.

- omar
