From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH] staging/omapdrm: garbage collect
 OMAP_DSS_DISPLAY_SUSPENDED
Date: Fri, 11 Jan 2013 09:47:25 +0100
Message-ID: <20130111084725.GB4313@luxor.wired.org>
References: <1357850547-32270-1-git-send-email-paolo.pisati@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:63727 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab3AKIr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 03:47:29 -0500
Content-Disposition: inline
In-Reply-To: <1357850547-32270-1-git-send-email-paolo.pisati@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <paolo.pisati@canonical.com>
Cc: Rob Clark <rob@ti.com>, linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, YAMANE Toshiaki <yamanetoshi@gmail.com>, Jani Nikula <jani.nikula@intel.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Jan 10, 2013 at 09:42:27PM +0100, Paolo Pisati wrote:
> Compilation fix - leftover from:
> 
> commit 998c336d4c7183301ed6a6ca93952f63e3cf694f
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Wed May 30 13:26:00 2012 +0300
> 
>     OMAPDSS: remove omap_dss_device's suspend/resume
> 
> Cc: stable <stable@vger.kernel.org> # v3.7
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>

bah, never mind:

https://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=commit;h=f5f9454c2145fa018c9808597739abce67114ac7

fixes the compilation breakagage.
It could be useful for v3.7 stable tough.
-- 
bye,
p.
