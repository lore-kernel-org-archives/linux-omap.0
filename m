From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/5] OMAP4: powerdomain data: Remove unsupported MPU
 powerdomain state
Date: Tue, 5 Jul 2011 23:29:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107052328580.4217@utopia.booyaka.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com> <1309552060-4547-6-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36160 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1GFF3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 01:29:33 -0400
In-Reply-To: <1309552060-4547-6-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> On OMAP4430 devices, because of boot ROM code bug, MPU OFF state can't
> be attempted independently. When coming out of MPU OFF state, ROM code
> disables the clocks of IVAHD, TESLA which is not desirable. Hence the
> MPU OFF state is not usable on OMAP4430 devices.
> 
> OMAP4460 onwards, MPU OFF state will be descoped completely because
> the DDR firewall falls in MPU power domain. When the MPU hit OFF state,
> DDR won't be accessible for other initiators. The deepest state supported
> is open switch retention (OSWR) just like CORE and PER PD on OMAP4430.
> 
> So in summary MPU power domain OFF state is not supported on OMAP4
> and onwards designs. Thanks to new PRCM design, device off mode can
> still be achieved with power domains hitting OSWR state.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [b-cousson@ti.com: Fix changelog typos]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'hardware_workarounds_3.1' branch.


- Paul
