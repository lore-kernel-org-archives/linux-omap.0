From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v3 1/7] DSPBRIDGE: replace IO_ADDRESS with ioremap
Date: Wed, 13 Jan 2010 17:57:25 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DDC1F24@dlee03.ent.ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37864 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756693Ab0AMX5b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 18:57:31 -0500
In-Reply-To: <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

>From: Ramirez Luna, Omar
>Sent: Monday, January 11, 2010 7:01 PM
>To: linux-omap
>Cc: Ramirez Luna, Omar; Tony Lindgren; Menon, Nishanth; Hiroshi Doyu; Ameya Palande; Felipe Contreras
>Subject: [PATCH v3 1/7] DSPBRIDGE: replace IO_ADDRESS with ioremap
>
>Use ioremap() instead of using IO_ADDRESS macro to make it generic.
>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> drivers/dsp/bridge/services/clk.c |   19 +++++++++++++------
> 1 files changed, 13 insertions(+), 6 deletions(-)
>

Pushed to dspbridge

- omar
