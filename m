From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 9/9] omap4: clockdomain: Fix the CPUx domain name
Date: Mon, 7 Feb 2011 21:58:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102072157030.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-10-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58667 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab1BHE66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 23:58:58 -0500
In-Reply-To: <1296813544-25170-10-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> The register naming convention for clock domain control inside
> power domain instance is:
> OMAPXXXX_<partition>_<power_domain>_<clock_domain>_CDOFFS
> 
> Both CPU0 and CPU1 use MPU as clock domain name instead of CPU0
> and CPU1.
> 
> Change the name to stick to the convention.
> The autogen scripts are updated accordingly.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 2.6.39 in the 'pwrdm_clkdm_b_2.6.39' branch of 
git://git.pwsan.com/linux-2.6 (along with patch 2/9).


- Paul
