From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/6] OMAP: omap_device: Create a default
 omap_device_pm_latency
Date: Tue, 27 Sep 2011 11:37:52 -0700
Message-ID: <20110927183752.GN6324@atomide.com>
References: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
 <1317143886-13285-6-git-send-email-b-cousson@ti.com>
 <20110927173048.GM6324@atomide.com>
 <87hb3xzvmo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51924 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab1I0Sh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Sep 2011 14:37:57 -0400
Content-Disposition: inline
In-Reply-To: <87hb3xzvmo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110927 10:56]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Isn't this racey between devices if the latency values get adjusted
> > automatically for each device?
> 
> A copy of this is made for each device (uses kmemdup later in the patch.)

Oh ok, sorry for the noise.

Tony
