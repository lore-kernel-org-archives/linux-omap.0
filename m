From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Tue, 05 Oct 2010 09:35:08 -0700
Message-ID: <87fwwktx6r.fsf@deeprootsystems.com>
References: <1286015771-22041-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46586 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0JEQfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 12:35:15 -0400
In-Reply-To: <1286015771-22041-1-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Sat, 2 Oct 2010 16:06:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, wim@iguana.be, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, p-basak2@ti.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Inorder to avoid any assumptions from bootloader, the watchdog
> timer module is reset during init. This enables the watchdog
> timer.
>
> Therefore, it is required to disable WDT after it is reset
> during init. Otherwise the system would reboot as per the default
> watchdog timer registers settings.
>
> Later, when the watchdog driver is loaded, the watchdog timer settings
> is adjusted as per the default timer_margin set in the driver and the
> driver would supports the normal operations supported by OMAP watchdog
> timer.
>
> Link to related discussions:
> https://patchwork.kernel.org/patch/219072/
>
> Issue reported by Kevin can be found at:
> https://patchwork.kernel.org/patch/217262/
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reported-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Tony, this should queue up for .37 on top of my pm-hwmods branch.
It applies cleanly to current l-o master.

Kevin
