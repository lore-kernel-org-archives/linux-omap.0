From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pandaboard] wl12xx borked after one up/down cycle
Date: Wed, 27 Nov 2013 15:51:35 -0800
Message-ID: <20131127235134.GG26766@atomide.com>
References: <526C396E.50600@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14780 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757190Ab3K0Xvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 18:51:37 -0500
Content-Disposition: inline
In-Reply-To: <526C396E.50600@math.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: linux-omap@vger.kernel.org

* Tobias Jakobi <tjakobi@math.uni-bielefeld.de> [131026 14:58]:
> And another one:
> https://bugzilla.kernel.org/show_bug.cgi?id=63821

OK this one turned out to be a pin mux issue probably caused
by a mismerge while rebasing patches for v3.10.

See the thread "[PATCH 0/2] ARM: dts: omap4: Fix pin muxing for wl12xx"
for the fix. Care to test it and if it works, update the bugzilla?

Regards,

Tony
