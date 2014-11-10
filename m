From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP Mailbox DTS patches for 3.19
Date: Mon, 10 Nov 2014 09:15:09 -0800
Message-ID: <20141110171508.GN31454@atomide.com>
References: <1415056055-64201-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26164 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753160AbaKJRP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 12:15:56 -0500
Content-Disposition: inline
In-Reply-To: <1415056055-64201-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Suman Anna <s-anna@ti.com> [141103 15:09]:
> Hi Tony,
> 
> The following OMAP mailbox DTS patches are based on 3.18-rc3 and are
> intended for the 3.19 merge window.
> 
> The first patch is new and adds the interrupts property to all the mailbox
> nodes on DRA7xx now that we have the DRA7xx interrupt crossbar driver
> functional and merged in the kernel.
> 
> The second patch enables the OMAP Mailbox DT users (there are none at the
> moment) to use the recently merged Mailbox framework API, and is a repost
> of the DTS patch [1] from the OMAP Mailbox framework adaptation series [2]
> after rebasing. The driver portion of the adaptation patch is posted
> separately so that Jassi can pick it up. Together, these are the last
> base mailbox dependent patches for Dave's PM work on AM335x.

Applying these two into omap-for-v3.19/dt thanks.

Tony

 
> [1] http://marc.info/?l=linux-omap&m=141038449717781&w=2
> [2] http://marc.info/?l=linux-omap&m=141038447817775&w=2
> 
> Suman Anna (2):
>   ARM: dts: DRA7: Add interrupts property to mailbox nodes
>   ARM: dts: OMAP2+: Add #mbox-cells property to all mailbox nodes
> 
>  arch/arm/boot/dts/am33xx.dtsi   |  1 +
>  arch/arm/boot/dts/am4372.dtsi   |  1 +
>  arch/arm/boot/dts/dra7.dtsi     | 64 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap2420.dtsi |  1 +
>  arch/arm/boot/dts/omap2430.dtsi |  1 +
>  arch/arm/boot/dts/omap3.dtsi    |  1 +
>  arch/arm/boot/dts/omap4.dtsi    |  1 +
>  arch/arm/boot/dts/omap5.dtsi    |  1 +
>  8 files changed, 71 insertions(+)
> 
> -- 
> 2.1.0
> 
