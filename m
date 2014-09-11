From: Tony Lindgren <tony@atomide.com>
Subject: Re: [REPOST PATCHv3] ARM: dts: OMAP2+: Add sub mailboxes device node
 information
Date: Thu, 11 Sep 2014 11:47:59 -0700
Message-ID: <20140911184759.GE18849@atomide.com>
References: <1410377243-8147-1-git-send-email-s-anna@ti.com>
 <1410377243-8147-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61321 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751922AbaIKSsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 14:48:05 -0400
Content-Disposition: inline
In-Reply-To: <1410377243-8147-2-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

* Suman Anna <s-anna@ti.com> [140910 12:28]:
> The sub-mailbox devices are added to the Mailbox DT nodes on
> OMAP2420, OMAP2430, OMAP3, AM33xx, AM43xx, OMAP4 and OMAP5
> family of SoCs. This data represents the same mailboxes that
> used to be represented in hwmod attribute data previously.
> The node name is chosen based on the .name field of
> omap_mbox_dev_info structure used in the hwmod data.

Thanks applying into omap-for-v3.18/dt.

Tony
