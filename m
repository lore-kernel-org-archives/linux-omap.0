From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: OSAL: Implement registry as linked list.
Date: Thu, 28 Jan 2010 18:32:46 -0600
Message-ID: <4B622CAE.8080606@ti.com>
References: <1264220763-11069-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755408Ab0A2Acv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jan 2010 19:32:51 -0500
In-Reply-To: <1264220763-11069-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 1/22/2010 10:26 PM, Omar Ramirez Luna wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> Change implementation of registry to a linked list.
>
> In future this will become to some static structures and probably list for DCD_REGKEY array.
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
> ---
>   drivers/dsp/bridge/services/regsup.c |  197 ++++++++++-----------------------
>   drivers/dsp/bridge/services/regsup.h |    3 -
>   2 files changed, 60 insertions(+), 140 deletions(-)
>

Pushed to dspbridge.

- omar
