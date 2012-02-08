From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: clock: cleanup CPUfreq leftovers
Date: Wed, 8 Feb 2012 11:16:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202081115390.26892@utopia.booyaka.com>
References: <1327960788-28905-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42037 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab2BHSQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:16:37 -0500
In-Reply-To: <1327960788-28905-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 30 Jan 2012, Kevin Hilman wrote:

> Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> longer need/use the clock framework code for filling up CPUfreq
> tables.  Remove it.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, now that the CPUfreq driver is in mainline (v3.3), this can be safely
> removed.

Thanks, queued for 3.4.


- Paul
