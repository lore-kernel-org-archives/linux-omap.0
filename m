From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] MFD: twl-core: move device_init_wakeup to after
 platform_device_add.
Date: Mon, 9 Jul 2012 13:15:19 +0200
Message-ID: <20120709111519.GM15345@sortiz-mobl>
References: <20120707085103.7b1a51ec@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25499 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910Ab2GILDt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jul 2012 07:03:49 -0400
Content-Disposition: inline
In-Reply-To: <20120707085103.7b1a51ec@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org

Hi Neil,

On Sat, Jul 07, 2012 at 08:51:03AM +1000, NeilBrown wrote:
> 
> 
> device_init_wakeup uses the dev_name() of the device to set the
> name of the wakeup_source which appears in
> /sys/kernel/debug/wakeup_sources.
> 
> For a platform device, that name is not set until platform_device_add
> calls dev_set_name.
> 
> So the call to device_init_wakeup() must be after the call to
> platform_device_add().
> Making this change causes correct names to appear in the
> wakeup_sources file.
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
