From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] OMAP2+: hwmod: add ability to late-init individual
 hwmods
Date: Wed, 23 Feb 2011 11:12:12 -0800
Message-ID: <20110223191212.GA15225@atomide.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <20110223071152.5874.54222.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27687 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536Ab1BWTMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 14:12:15 -0500
Content-Disposition: inline
In-Reply-To: <20110223071152.5874.54222.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Hi,

* Paul Walmsley <paul@pwsan.com> [110222 23:11]:
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> +int __init omap_hwmod_late_init_one(const char *oh_name)

How about the following naming changes to avoid confusion:

omap_hwmod_init			-> omap_hwmod_register
omap_hwmod_late_init		-> omap_hwmod_init
omap_hwmod_late_init_one	-> omap_hwmod_init_one

This is because "late_init" gets actually called very early
during the boot.

Regards,

Tony
