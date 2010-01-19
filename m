From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Fix wrong condition on NODE_GetUUIDProps
Date: Mon, 18 Jan 2010 19:57:32 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DED56DF@dlee03.ent.ti.com>
References: <1263866284-5587-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43407 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385Ab0ASB5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 20:57:38 -0500
In-Reply-To: <1263866284-5587-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ramirez Luna, Omar
>Sent: Monday, January 18, 2010 7:58 PM
>To: linux-omap
>Cc: Ameya Palande; Hiroshi Doyu; Felipe Contreras; Menon, Nishanth; Ramirez Luna, Omar
>Subject: [PATCH] DSPBRIDGE: Fix wrong condition on NODE_GetUUIDProps
>
>Fix wrong condition because of a wrong patch included.
>
>Discovered-by: Ernesto Ramos Falcon <ernesto@ti.com>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> drivers/dsp/bridge/rmgr/node.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>

As this a fix from a previous patch, pushed to dspbridge.

- omar
