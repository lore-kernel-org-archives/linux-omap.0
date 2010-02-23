From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: Reclaim all pending buffer on resource
 cleanup
Date: Tue, 23 Feb 2010 10:23:27 -0600
Message-ID: <4B8400FF.4010003@ti.com>
References: <496565EC904933469F292DDA3F1663E602CA2B9606@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47223 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249Ab0BWQXf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 11:23:35 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B9606@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On 2/16/2010 6:40 PM, Guzman Lugo, Fernando wrote:
>  From 6ed51fea16df51e88a25bda2b9908f0a43b86303 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Tue, 16 Feb 2010 18:32:02 -0600
> Subject: [PATCH] DSPBRIDGE: Reclaim all pending buffer on resource cleanup
>
> Before in case of pending buffer while we try to close
> a stream, it was doing only one reclaim, in the case there
> were more pending buffer the second STRM_Close would also
> fail, now all the pending buffers are reclaim.
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
> ---
>   drivers/dsp/bridge/rmgr/drv.c |   22 +++++++++++++---------
>   1 files changed, 13 insertions(+), 9 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
