From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as platform driver
Date: Fri, 03 Sep 2010 15:49:49 -0700
Message-ID: <87eidatpbm.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402781CE908@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45869 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0ICWtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 18:49:53 -0400
Received: by yxp4 with SMTP id 4so913872yxp.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 15:49:52 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402781CE908@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Fri, 3 Sep 2010 21:51:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Sawant, Anand" <sawant@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> If there are no further comments, can you please stage this patch
> series on hwmods-omap4 branch?

Reviewed.  Still a long ways to go..., also  I didn't see you address
the typo pointed out by Mika Westerberg on PATCH 03/11.

Also, testing on omap3430/n900, I noticed an interesting failure during
boot.  During boot (in the middle of omap3_pm_init(), a DMA interrupt
fires and the SPI RX callback is called which faults when accessing it's
registers.

I did not debug this further, but is something that needs investigation.

Also, in the next version, please report how it was tested on the
various OMAPs.  In particular, what peripherals using DMA were tested.
Just a boot test is not sufficient when making major functional changes
like this.  Drivers using DMA need to be tested as well.

Kevin


