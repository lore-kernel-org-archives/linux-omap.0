From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix
 CONTROL_DSIPHY register fields"
Date: Tue, 8 May 2012 16:20:57 -0700
Message-ID: <20120508232057.GR5088@atomide.com>
References: <1334837356-2440-1-git-send-email-archit@ti.com>
 <4FA7AB89.5010904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14849 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab2EHXVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:21:02 -0400
Content-Disposition: inline
In-Reply-To: <4FA7AB89.5010904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: paul@pwsan.com, tomi.valkeinen@ti.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, b-cousson@ti.com, stable@vger.kernel.org

* Archit Taneja <a0393947@ti.com> [120507 04:05]:
> Hi Tony, Paul,
> 
> Could you please consider this patch for the next -rc cycle, it
> fixes contention errors seen on the DSI panel on OMAP4 SDP.

I have this already in fixes branch as commit
08ca7444f589bedf9ad5d82883e5d0754852d73b.

Regards,

Tony
