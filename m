From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: DSPBRIDGE: Implement WDT3 to notify DSP hangs
Date: Thu, 22 Apr 2010 16:39:44 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC1647E@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CAEAB813@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50293 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab0DVVjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 17:39:51 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CAEAB813@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 7349444302a782997d6eba64d46908c0915c12a1 Mon Sep 17 00:00:00 2001
>From: Fernando Guzman Lugo <x0095840@ti.com>
>Date: Tue, 30 Mar 2010 21:52:25 -0600
>Subject: [PATCH] DSPBRIDGE: Implement WDT3 to notify DSP hangs
>
>This patch implements wdt3 feature to notify wdt3 overflow.
>This new feature can be chosen by doing make menuconfig,
>default is disabled.
>
>WDT3 is upcount Timer incrementing every functional clock tick
>till it reaches programmed timeout value. On reaching timeout
>value, if INTerrupt bit for WDT3 is enabled, then an interrupt
>is generated to MPU.
>
>After receiving this Interrupt, any client can register within
>bridge driver to be notified of this event and prepare for
>DSP recovery.
>
>Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>Signed-off-by: Armando Uribe <x0095078@ti.com>
>Signed-off-by: Somashekar Chandrappa <somashekar.c@ti.com>
>---

Pushed to dspbridge.

- omar
