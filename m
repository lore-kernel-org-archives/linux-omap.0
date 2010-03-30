From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: clock: fix enable bit used for dpll4_m4x2 clock
Date: Tue, 30 Mar 2010 01:34:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1003300131390.14474@utopia.booyaka.com>
References: <1269579313-10064-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53177 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab0C3HeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 03:34:17 -0400
In-Reply-To: <1269579313-10064-1-git-send-email-ranjithl@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: b-cousson@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org

Hi Ranjith,

On Fri, 26 Mar 2010, Ranjith Lohithakshan wrote:

> The enable bit for dpll4_m4x2 clock should be OMAP3430_PWRDN_DSS1_SHIFT.
> The code erroneously uses OMAP3430_PWRDN_CAM_SHIFT which is meant for
> dpll4_m5x2 clock.
> 
> This came into notice during a recent review of the clock tree.
> 
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Thanks, queued for 2.6.34-rcX.


- Paul
