From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Fix wrong prints of DBC_ENSURE()
Date: Mon, 14 Jun 2010 17:25:20 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E873217@dlee03.ent.ti.com>
References: <1276194515-3216-1-git-send-email-ivan.gomez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55259 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756987Ab0FNWZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 18:25:25 -0400
In-Reply-To: <1276194515-3216-1-git-send-email-ivan.gomez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gomez
>Castellanos, Ivan
>
>The patch "DSPBRIDGE: Check pointer instead of using MEM_IS_VALID_HANDLE
>macro" uncovered an issue when calling the assertion macros after the
>pointer was freed, but not set to NULL.
>
>This issue was not showing before the above patch because the macro
>MEM_IS_VALID_HANDLE checked for the pointer and signature, which was
>not good because it dereferenced a pointer that was already freed.
>
>This patch removes DBC_ENSURE() whenever it checks for a previously
>freed pointer, or fix the code to avoid wrong assertions printing.
>
>Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
>---
> drivers/dsp/bridge/pmgr/chnl.c  |    2 --
> drivers/dsp/bridge/pmgr/dev.c   |    3 ---
> drivers/dsp/bridge/rmgr/dbdcd.c |    5 ++---
> drivers/dsp/bridge/rmgr/disp.c  |    2 --
> drivers/dsp/bridge/rmgr/drv.c   |    2 +-
> drivers/dsp/bridge/rmgr/mgr.c   |    2 --
> drivers/dsp/bridge/rmgr/nldr.c  |    1 -
> drivers/dsp/bridge/rmgr/strm.c  |   11 ++++-------
> 8 files changed, 7 insertions(+), 21 deletions(-)
>

Pushed to dspbridge.

- omar
