From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
 break because of clktrctrl_mask
Date: Thu, 6 Jan 2011 10:59:42 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101061058260.22048@utopia.booyaka.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48765 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1AFR7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 12:59:45 -0500
In-Reply-To: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, 5 Jan 2011, Santosh Shilimkar wrote:

> struct clockdomain member clktrctrl_mask is available for only for OMAP2
> and OMAP3 architectures. Technially it is also used only for these archs
> but this breaks the build with custom OMAP4 configuration.

...

> Fix the build break by dropping the #ifdef as suggested by Paul Walmsley
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>


Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
