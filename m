From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/2] dspbridge: reorganize initialization and probe
Date: Mon, 14 Jun 2010 12:59:04 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E872E46@dlee03.ent.ti.com>
References: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48799 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab0FNR7K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 13:59:10 -0400
In-Reply-To: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ramirez Luna, Omar
>
>Split the functions to have cleaner error handling paths, this
>will aslo cover a case where bridge initialization has failed but
>device entry is still available which leads to unknown behavior.
>
>Omar Ramirez Luna (2):
>  DSPRBIDGE: split probe from bridge initializations
>  DSPBRIDGE: reorganize probe function
>
> drivers/dsp/bridge/rmgr/drv_interface.c |  202 ++++++++++++++++++-------------
> 1 files changed, 118 insertions(+), 84 deletions(-)

Pushed to dspbridge.

- omar
