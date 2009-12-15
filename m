From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg
 access.
Date: Tue, 15 Dec 2009 09:08:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912150906550.12561@utopia.booyaka.com>
References: <1260883872-22299-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59001 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbZLOQIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 11:08:05 -0500
In-Reply-To: <1260883872-22299-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Abhijit,

On Tue, 15 Dec 2009, Abhijit Pagare wrote:

> In OMAP2/3 some of the clock-domains which did not have control
> facility were being falsely written to and read using the CM_CLKSTCTRL
> register though it did not exist for them. One check is added to remove
> this flaw.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Thanks Abhijit, queueing for .33-rcX.


- Paul

