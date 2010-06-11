From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Always delete nodes during resource cleanup
Date: Fri, 11 Jun 2010 00:09:37 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E7CD93D@dlee03.ent.ti.com>
References: <B852767254C5C94EBB1040EE0EFA060092D763FC@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59568 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab0FKFJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 01:09:41 -0400
In-Reply-To: <B852767254C5C94EBB1040EE0EFA060092D763FC@dlee01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ramos
>Falcon, Ernesto
>Sent: Friday, April 16, 2010 10:23 PM
>To: linux-omap@vger.kernel.org
>Cc: Ameya Palande; Doyu Hiroshi (Nokia-D/Helsinki); Contreras Felipe (Nokia-D/Helsinki)
>Subject: [PATCH] DSPBRIDGE: Always delete nodes during resource cleanup
>
>From 9b263cc8cf0dea7e440aabb77fc88d06e01d62a4 Mon Sep 17 00:00:00 2001
>From: Ernesto Ramos <ernesto@ernesto-desktop.(none)>
>Date: Thu, 18 Mar 2010 23:48:56 -0600
>Subject: [PATCH] DSPBRIDGE: Always delete nodes during resource cleanup
>
>Right now, during resource clean up, nodes are not being
>deleted if they are in state NODE_DONE. This fix makes
>sure they are deleted if they are in any valid state.
>
>Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>---
> drivers/dsp/bridge/rmgr/drv.c |   12 +++---------
> 1 files changed, 3 insertions(+), 9 deletions(-)
>

Pushed to dspbridge.

- Omar
