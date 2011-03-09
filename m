From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: mux: Remove the use of IDLE flag.
Date: Wed, 9 Mar 2011 11:42:11 -0800
Message-ID: <20110309194211.GO26463@atomide.com>
References: <1299656738-7885-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34618 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab1CITmP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 14:42:15 -0500
Content-Disposition: inline
In-Reply-To: <1299656738-7885-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, santosh.shilimkar@ti.com

* sricharan <r.sricharan@ti.com> [110308 23:43]:
> Currently OMAP_DEVICE_PAD_IDLE flag is used to mux pins
> dynamically. This can be simplified by using the enabled
> state variable of each pad. This also fixes the issue of
> the static pads not getting muxed after idling and
> disable/enable state transitions.

Thanks applying.

Tony
