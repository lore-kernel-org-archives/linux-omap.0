From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: SRAM: fix size for OMAP1611 SoCs
Date: Thu, 9 Dec 2010 16:30:00 -0800
Message-ID: <20101210002959.GN3054@atomide.com>
References: <1291770132-2283-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:26948 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490Ab0LJAaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 19:30:07 -0500
Content-Disposition: inline
In-Reply-To: <1291770132-2283-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tim Bird <tim.bird@am.sony.com>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101207 17:06]:
> Kernel was failing to boot on omap1611 based OSK boards due to
> mis-configured SRAM size.  Existing code was using a hard-coded value
> for 250k, which was then rounded down by PAGE_SIZE.  Increasing this to
> 256k allows kernel to boot on omap1611 SoCs.
> 
> Problem reported by and initial fix suggested by Tim Bird.
> 
> Thanks to Tony Lindgren for helping diagnose the problem to being
> specific to OMAP1611 and not affecting OMAP1610/OMAP1623.

Thanks, will queue this fix.

Tony
