From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V3] ARM: GIC: Convert GIC library to use the IO relaxed
 operations
Date: Wed, 04 May 2011 18:04:15 +0100
Message-ID: <1304528655.1935.4.camel@craptop>
References: <1304058131-8375-1-git-send-email-santosh.shilimkar@ti.com>
	 <1304417481.19196.60.camel@e102109-lin.cambridge.arm.com>
	 <4DBFD59D.50008@ti.com>  <4DC13252.2080308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46584 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916Ab1EDREW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 13:04:22 -0400
In-Reply-To: <4DC13252.2080308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Santosh,

On Wed, 2011-05-04 at 12:02 +0100, Santosh Shilimkar wrote:
> Will,
> Can you queue this patch part of your series please?

Yes, providing that Russell is happy to pull the IRQ stuff (fasteoi,
Tegra changes and this) from me.

Will

