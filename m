From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] dspbridge: minor clean up in memdefs.h
Date: Thu, 28 Jan 2010 18:33:02 -0600
Message-ID: <4B622CBE.5050508@ti.com>
References: <1264595951-11572-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46254 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab0A2AdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 19:33:07 -0500
In-Reply-To: <1264595951-11572-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 1/27/2010 6:39 AM, andy.shevchenko@gmail.com wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> Remove useless macroses. They were doing nothing, so it's clear to just get rid
> of them.
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/memdefs.h |    3 ---
>   drivers/dsp/bridge/wmd/tiomap_io.c             |    5 ++---
>   2 files changed, 2 insertions(+), 6 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge.

- omar
