From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: dra7x-evm: DCAN pinmux fixes
Date: Fri, 6 Mar 2015 09:16:33 -0800
Message-ID: <20150306171633.GV13520@atomide.com>
References: <1425562363-19338-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery8.ore.mailhop.org ([54.148.222.11]:46766 "EHLO
	pmta2.delivery8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053AbbCFRjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 12:39:13 -0500
Received: from smtp7.ore.mailhop.org (172.31.18.134) by pmta2.delivery1.ore.mailhop.org id hv7j5m20u50g for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2015 17:22:23 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <1425562363-19338-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: nm@ti.com, nsekhar@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150305 05:34]:
> Hi Tony,
> 
> These are some fixes to the DCAN pinmux.
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   ARM: dts: dra7x-evm: Don't use dcan1_rx.gpio1_15 in DCAN pinctrl
>   ARM: dts: dra7x-evm: avoid possible contention while muxing on CAN
>     lines
> 
>  arch/arm/boot/dts/dra7-evm.dts  | 10 ++++------
>  arch/arm/boot/dts/dra72-evm.dts | 10 ++++------
>  2 files changed, 8 insertions(+), 12 deletions(-)

Applying both into omap-for-v4.0/fixes thanks.

Tony
