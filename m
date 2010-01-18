From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/3] DSPBRIDGE: Undo allocation of resources in case of
 cp_to_usr fails
Date: Mon, 18 Jan 2010 12:30:17 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE50D10@dlee03.ent.ti.com>
References: <1263431476-19206-1-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-2-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59667 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab0ARSaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:30:21 -0500
In-Reply-To: <1263431476-19206-3-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

>From: Ramirez Luna, Omar on Wednesday, January 13, 2010 7:11 PM
>
>From: Ernesto Ramos <ernesto@ti.com>
>
>Release resources allocated during MAP, Node Allocation,
>STRM Buf Allocation in the case of cp_to_usr fails.
>
>Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>CC: Nishanth Menon <nm@ti.com>
>CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
>CC: Ameya Palande <ameya.palande@nokia.com>
>---
> drivers/dsp/bridge/pmgr/wcd.c |   35 ++++++++++++++++++++++++++++-------
> 1 files changed, 28 insertions(+), 7 deletions(-)
>

Pushed to dspbridge

- omar
