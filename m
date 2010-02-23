From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: cleanup patch for DRV_RemoveAllSTRMResElements
 function
Date: Tue, 23 Feb 2010 10:23:23 -0600
Message-ID: <4B8400FB.6070006@ti.com>
References: <496565EC904933469F292DDA3F1663E602CA2B9605@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47216 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249Ab0BWQXa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 11:23:30 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B9605@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On 2/16/2010 6:39 PM, Guzman Lugo, Fernando wrote:
>  From 718174a6ed1b54ce0120080a953d7f0a5ebb8d6d Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Tue, 16 Feb 2010 18:14:26 -0600
> Subject: [PATCH] DSPBRIDGE: cleanup patch for DRV_RemoveAllSTRMResElements function
>
> This patches clenaups the function DRV_RemoveAllSTRMResElements and
> DRV_ProcFreeSTRMRes and it turns them into one function.
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
> ---
>   drivers/dsp/bridge/rmgr/drv.c |   66 ++++++++++++----------------------------
>   1 files changed, 20 insertions(+), 46 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar

