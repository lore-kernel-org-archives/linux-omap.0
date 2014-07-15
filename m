From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: DTS: omap5-uevm: Enable audio (for 3.17)
Date: Tue, 15 Jul 2014 00:21:51 -0700
Message-ID: <20140715072151.GM20068@atomide.com>
References: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44999 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757712AbaGOHXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2014 03:23:15 -0400
Content-Disposition: inline
In-Reply-To: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140710 04:26]:
> Hi,
> 
> This set is to enable audio (finally) on the omap5-uevm. We have been waiting
> for the palmas 32K clock driver to make it to upstream, which it did and it is
> already in linux-next.
> 
> With the three patch we can have audio working on omap5-uevm with linux-next.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: DTS: omap5-uevm: Enable palmas clk32kgaudio clock
>   ARM: DTS: omap5-uevm: Add node for twl6040 audio codec
>   ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040)
> 
>  arch/arm/boot/dts/omap5-uevm.dts | 68 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 6 deletions(-)

Applying into omap-for-v3.17/dt thanks.

Tony
