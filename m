From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/8] OMAP2+: hwmod: add ability to late-init individual
 hwmods
Date: Thu, 24 Feb 2011 02:06:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102240204190.6198@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <20110223071152.5874.54222.stgit@twilight.localdomain> <20110223191212.GA15225@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57939 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699Ab1BXJGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 04:06:06 -0500
In-Reply-To: <20110223191212.GA15225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

On Wed, 23 Feb 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [110222 23:11]:
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > +int __init omap_hwmod_late_init_one(const char *oh_name)
> 
> How about the following naming changes to avoid confusion:
> 
> omap_hwmod_init			-> omap_hwmod_register
> omap_hwmod_late_init		-> omap_hwmod_init
> omap_hwmod_late_init_one	-> omap_hwmod_init_one
> 
> This is because "late_init" gets actually called very early
> during the boot.

Sounds good to me.  Will write a patch to make this change,

- Paul
