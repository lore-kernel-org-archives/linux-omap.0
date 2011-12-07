From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Tue, 06 Dec 2011 16:24:04 -0800
Message-ID: <87y5up44bf.fsf@ti.com>
References: <hvaibhav@ti.com>
	<1322808204-12878-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59182 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753606Ab1LGAYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Dec 2011 19:24:10 -0500
Received: by mail-gy0-f171.google.com with SMTP id r15so4216928ghr.16
        for <linux-omap@vger.kernel.org>; Tue, 06 Dec 2011 16:24:09 -0800 (PST)
In-Reply-To: <1322808204-12878-1-git-send-email-hvaibhav@ti.com>
	(hvaibhav@ti.com's message of "Fri, 2 Dec 2011 12:13:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

<hvaibhav@ti.com> writes:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> This patch set adds support for AM335x device having
> Cortex-A8 MPU.
>
> Official website - http://www.ti.com/product/am3359
>
> AM335X is treated as another OMAP3 variant, where,
> along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> and the respective type is AM335X, which is newly added device in
> the family.
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> cpu_is_am335x() checks return success for AM335X.
>
> Also, I have validated OMAP3 boot test with this patch-series on
> OMAP3EVM.

Tony, this series looks good to me.

I've also tested it on a BeagleBone, so feel free to also add:

Tested-by: Kevin Hilman <khilman@ti.com>

Kevin
