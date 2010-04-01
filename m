From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] OMAP:GPIO:Common platform code for all OMAPs
Date: Thu, 1 Apr 2010 02:34:26 -0700
Message-ID: <20100401093425.GI31200@atomide.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
 <1270038239-1090-5-git-send-email-charu@ti.com>
 <1270038239-1090-6-git-send-email-charu@ti.com>
 <1270038239-1090-7-git-send-email-charu@ti.com>
 <1270038239-1090-8-git-send-email-charu@ti.com>
 <1270038239-1090-9-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57895 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0DAJcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:32:33 -0400
Content-Disposition: inline
In-Reply-To: <1270038239-1090-9-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com

* Charulatha V <charu@ti.com> [100331 05:15]:
> This patch adds support for common GPIO code in plat-omap layer
> to perform most common operations for all OMAPs. This is handled
> by getting function pointers and register offsets from
> architecture specific files in mach-omap layer.
> 
> The common APIs are handled by plat-omap/gpio.c file. Specific function,
> eg., get_gpio_bank, set_gpio_triggering, etc., are handled differently
> in different architectures. Hence they are handled in mach-omap layer.
> 
> This patch also adds support for passing platform_data for OMAP2PLUS.
> For OMAP1, it still supports the old way of doing omap_gpio_init which
> would be handled in mach-omap1 layer.
> 
> This patch is in prepartion for HWMOD FW adaptation for GPIO module.

Sounds like this needs to be broken down into smaller patches. Let's first
get initializing things with platform data working, only then start patching
the functional code.

Tony
