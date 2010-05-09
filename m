From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 5/5] DSPBRIDGE: Removes checkpatch error with
 file_operations
Date: Sat, 8 May 2010 23:27:57 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD4964@dlee03.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC26227F2@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53583 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0EIE2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 May 2010 00:28:02 -0400
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90EC26227F2@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Uribe de Leon, Armando" <x0095078@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 8d29388e77d01a9cf549a5adfdc8f21244f14cad Mon Sep 17 00:00:00 2001
>From: Armando Uribe De Leon <x0095078@ti.com>
>Date: Thu, 8 Apr 2010 19:26:23 -0500
>Subject: [PATCH 5/5] DSPBRIDGE: Removes checkpatch error with file_operations
>
>This patch removes the checptach error sue to the missing const modifier in file_operations.
>
>Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
>---
> drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>

Pushed to dspbridge.

- omar
