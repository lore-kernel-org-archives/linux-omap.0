From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: mux: Remove the use of IDLE flag.
Date: Tue, 8 Mar 2011 08:40:33 -0800
Message-ID: <20110308164033.GC26463@atomide.com>
References: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27418 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab1CHQko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 11:40:44 -0500
Content-Disposition: inline
In-Reply-To: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, santosh.shilimkar@ti.com, paul@pswan.com

* sricharan <r.sricharan@ti.com> [110306 20:33]:
> Currently OMAP_DEVICE_PAD_IDLE flag is used to mux pins
> dynamically. This can be simplified by using the enabled
> state variable of each pad. This also fixes the issue of
> the static pads not getting muxed after idling and
> disable/enable state transitions.

Looks good, can you please repost one more time with linux-arm-kernel
mailing list also Cc'd?

Thanks,

Tony
