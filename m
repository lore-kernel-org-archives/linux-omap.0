From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 6/11] OMAP1: dmtimer: conversion to platform devices
Date: Wed, 05 Jan 2011 15:51:08 -0800
Message-ID: <87r5cqvrir.fsf@ti.com>
References: <1294228127-11549-1-git-send-email-tarun.kanti@ti.com>
	<1294228127-11549-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43414 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753581Ab1AEXvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 18:51:12 -0500
Received: by mail-yx0-f170.google.com with SMTP id 11so9898184yxi.15
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 15:51:12 -0800 (PST)
In-Reply-To: <1294228127-11549-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 5 Jan 2011 17:18:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Hi Tarun,

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> Convert OMAP1 dmtimers into a platform devices and then registers with
> device model framework so that it can be bound to corresponding driver.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>

One minor nit...

[...]

> +int __init omap1_dm_timer_init(void)
> +{
> +	int i;
> +	int ret;
> +	struct dmtimer_platform_data *pdata;
> +	struct platform_device *pdev;
> +
> +	pr_debug("%s: +\n", __func__);

stray debug print?

Kevin
