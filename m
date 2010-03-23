From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/3] DSPBRIDGE: Remove hw_mbox.c and hw_mbox.h not needed
 anymore
Date: Tue, 23 Mar 2010 12:33:31 -0500
Message-ID: <4BA8FB6B.7060809@ti.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18E2@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43028 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab0CWRdh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 13:33:37 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA7C18E2@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On 2/12/2010 8:03 PM, Guzman Lugo, Fernando wrote:
>  From 5451312f78b6631c9cfacfde10928f481e60b65c Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Wed, 27 Jan 2010 20:12:38 -0600
> Subject: [PATCH] DSPBRIDGE: Remove hw_mbox.c and hw_mbox.h not needed anymore
>
> Because of mailbox migration now the files hw_mbox.c
> and hw_mbox.h are not needed anymore.
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
> ---
>   drivers/dsp/bridge/hw/hw_mbox.c |  248 -----------------------------
>   drivers/dsp/bridge/hw/hw_mbox.h |  326 ---------------------------------------
>   2 files changed, 0 insertions(+), 574 deletions(-)
>   delete mode 100644 drivers/dsp/bridge/hw/hw_mbox.c
>   delete mode 100644 drivers/dsp/bridge/hw/hw_mbox.h
>

Rebased and pushed, deleted MLBAccInt.h and MLBRegAcM.h too.

- omar
