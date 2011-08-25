From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
Date: Thu, 25 Aug 2011 13:49:33 +0200
Message-ID: <4E5636CD.4080302@ti.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50456 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352Ab1HYLtj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 07:49:39 -0400
In-Reply-To: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Venkat,

On 8/24/2011 9:46 PM, S, Venkatraman wrote:
> As part of an effort to get single ARM kernel binary [1],
> multiple  definitions of NR_IRQS under various platforms
> have to be reconciled and abstracted away from common code.
>
> This patch series takes the small step of populating the
> machine descriptors with the pre-existing nr_irqs field.
> Eventually, the common irq handler code will only look at this
> field and not the compile time constant.

Not related to this patch, but still on that topic. The current NR_IRQS 
depends as well on board stuff, like for example : the Phoenix 
IRQs:TWL6030_IRQ_BASE, TWL6040_CODEC_IRQ_BASE.
Is there a plan to get rid of this static defines?

Thanks,
Benoit
