From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5 0/12] dmtimer adaptation to platform_driver
Date: Tue, 14 Dec 2010 18:06:34 -0800
Message-ID: <874oafn61h.fsf@deeprootsystems.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:44121 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0LOCGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 21:06:38 -0500
Received: by gwb20 with SMTP id 20so1086813gwb.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 18:06:38 -0800 (PST)
In-Reply-To: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 7 Dec 2010 05:14:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> dmtimer adaptation to platform_driver.
>
> This patch series is adaptation of dmtimer code to platform driver
> using omap_device and omap_hwmod abstraction.
>
> Tested on following platforms:
> OMAP4430, OMAP3430, OMAP3630, OMAP2430
> OMAP2420 -- Image with omap2plus_defconfig in too large to download on N800.

And OMAP1?

Kevin
