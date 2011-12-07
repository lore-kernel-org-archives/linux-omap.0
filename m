From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 00/11] arm:omap:am33xx: Add basic voltage, power,
 clock & HWMOD data
Date: Wed, 7 Dec 2011 13:25:07 -0800
Message-ID: <20111207212507.GM31337@atomide.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58460 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686Ab1LGVZK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 16:25:10 -0500
Content-Disposition: inline
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

* Vaibhav Hiremath <hvaibhav@ti.com> [111120 08:44]:
> 
>  34 files changed, 7525 insertions(+), 15 deletions(-)

Clearly we can't merge this amount of static SoC specific
hwmod/mux data after the all that's been discussed over
this year.

We just have to have a better way of doing this.

For now, we already have the SoC specific init functions
available, so I suggest taking a hard look how to dynamically
allocate these data structures and populate them with the
SoC specific init functions.

Then later on we may be able to pass some of the data such
as module base addresses from device tree. But I'm guessing
that the SoC specific inits should already squeeze this down
into something tolerable.

Regards,

Tony
