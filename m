From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP2+: fix compilation warnings.
Date: Wed, 1 Jun 2011 00:27:27 -0700
Message-ID: <20110601072727.GW11352@atomide.com>
References: <1306907936-28841-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29478 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755379Ab1FAH1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 03:27:30 -0400
Content-Disposition: inline
In-Reply-To: <1306907936-28841-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

* Govindraj.R <govindraj.raja@ti.com> [110531 22:54]:
> Fix below compilation warnings.
> 
> arch/arm/mach-omap2/omap_hwmod.c: In function 'omap_hwmod_for_each':
> arch/arm/mach-omap2/omap_hwmod.c:1631: warning: 'ret' may be used uninitialized in this function
> 
> arch/arm/mach-omap2/mux.c: In function 'omap_mux_get_gpio':
> arch/arm/mach-omap2/mux.c:917: warning: 'm' may be used uninitialized in this function

Thanks, applying into devel-fixes. Whee, is the only warning now
remaining the h4 keypad warning?

Tony
