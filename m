From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Remove dmm device creation
Date: Wed, 20 Mar 2013 11:26:25 +0530
Message-ID: <51494F89.4050308@ti.com>
References: <1363754624-5209-1-git-send-email-andy.gross@ti.com> <1363754624-5209-3-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297Ab3CTFyj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 01:54:39 -0400
In-Reply-To: <1363754624-5209-3-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Gross <andy.gross@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Nishanth Menon <nm@ti.com>

On Wednesday 20 March 2013 10:13 AM, Andy Gross wrote:
> Remove DMM device creation via the hwmod entry.  The DMM device will
> now be enumerated as part of the device tree information for the
> processor.
> 
> Signed-off-by: Andy Gross <andy.gross@ti.com>
> ---
OMAP4 is still not made DT only so I suggest you to hold on for this patch
till that happens.

Regards,
Santosh
