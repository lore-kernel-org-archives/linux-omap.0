From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] ARM: OMAP1: PM: Remove bogus fiq_[enable/disable]
 tuple
Date: Wed, 20 Feb 2013 08:09:53 -0800
Message-ID: <20130220160953.GO5724@atomide.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59703 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758703Ab3BTQJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 11:09:57 -0500
Content-Disposition: inline
In-Reply-To: <1361373527-21695-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

Hi,

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130220 07:21]:
> On OMAP platform, FIQ is reserved for secure environment only. If at all
> the FIQ needs to be disabled, it involves going through security
> API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.
> 
> So just get rid of it.

This is not true for all omaps, needs to be checked carefully
at what point it was made HS omap only. We have at least
mach-omap1//ams-delta-fiq.c that's being used.

Regards,

Tony
