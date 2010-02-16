From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: DSPBRIDGE: Replace page_address with kmap
Date: Tue, 16 Feb 2010 17:48:36 -0600
Message-ID: <4B7B2ED4.1040105@ti.com>
References: <496565EC904933469F292DDA3F1663E602AA6587B3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45401 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933620Ab0BPXsm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 18:48:42 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA6587B3@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 2/8/2010 4:14 PM, Guzman Lugo, Fernando wrote:
>  From 07880b3410ad19962d16ce1415f0423dfeed17da Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Fri, 5 Feb 2010 01:35:35 -0600
> Subject: [PATCH] DSPBRIDGE: Replace page_address with kmap
>
> Replace page_address with kmap to get address in case of high mem allocation.
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
