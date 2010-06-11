From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v2] dspbridge: deh: fix corruption on MMU fault
Date: Fri, 11 Jun 2010 00:25:22 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E7CD943@dlee03.ent.ti.com>
References: <1274024668-20899-1-git-send-email-felipe.contreras@gmail.com>
 <1274024668-20899-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36834 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063Ab0FKFZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 01:25:27 -0400
In-Reply-To: <1274024668-20899-2-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Sunday, May 16, 2010 10:44 AM
>To: linux-omap
>Cc: Ramirez Luna, Omar; Guzman Lugo, Fernando; Chitriki Rudramuni, Deepak; Felipe Contreras
>Subject: [PATCH v2] dspbridge: deh: fix corruption on MMU fault
>
>The DSP might misbehave and write to the dummy memory. So let's make
>sure that nobody else is using the pages related to it by grabbing a
>full page.
>
>Based on the analysis of Deepak Chitriki.
>
>Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>---
> drivers/dsp/bridge/core/ue_deh.c |   11 +++--------
> 1 files changed, 3 insertions(+), 8 deletions(-)
>

Pushed to dspbridge.

- Omar
