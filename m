From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Avoid possible buffer overflow in load_lib
Date: Fri, 11 Jun 2010 00:08:02 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E7CD93B@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CB048972@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59501 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522Ab0FKFII convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 01:08:08 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB048972@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Guzman
>Lugo, Fernando
>Sent: Thursday, April 08, 2010 7:19 PM
>To: linux-omap@vger.kernel.org
>Cc: Hiroshi DOYU; Ameya Palande; felipe.contreras@nokia.com
>Subject: [PATCH] DSPBRIDGE: Avoid possible buffer overflow in load_lib
>
>From 770bb122ac96f6f87a4b0d93b98db683ae16eb36 Mon Sep 17 00:00:00 2001
>From: Ernesto Ramos <ernesto@ti.com>
>Date: Wed, 24 Mar 2010 16:40:02 -0600
>Subject: [PATCH] DSPBRIDGE: Avoid possible buffer overflow in load_lib
>
>Avoid possible buffer overflow in load_lib.
>Array pers_lib_table may use index 5.
>Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>---
> drivers/dsp/bridge/rmgr/nldr.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>

Pushed to dspbridge.

- Omar
