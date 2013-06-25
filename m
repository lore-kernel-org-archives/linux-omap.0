From: Balaji T K <balajitk@ti.com>
Subject: Re: MMC breakage on 3.11/cleanup
Date: Tue, 25 Jun 2013 11:56:23 +0530
Message-ID: <51C9380F.6000604@ti.com>
References: <CAD=GYpZGdLem1igUsLq7DzMu-Z=9d6apS-aT=MJ59_-ytZan7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33403 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab3FYG02 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 02:26:28 -0400
In-Reply-To: <CAD=GYpZGdLem1igUsLq7DzMu-Z=9d6apS-aT=MJ59_-ytZan7w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Tuesday 25 June 2013 03:57 AM, Joel A Fernandes wrote:
> Hi Tony,
>
> Following branch breaks MMC for me on am33xx (beaglebone):
> http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.11/cleanup
>
> I tried to work around it by specifying interrupt and reg property in DT:
>        mmc1: mmc@48060000 {
>           compatible = "ti,omap3-hsmmc";
>           ti,hwmods = "mmc1";
>           ti,dual-volt;
>           ti,needs-special-reset;
>           dmas = <&edma 24
>              &edma 25>;
>           dma-names = "tx", "rx";
>           interrupts = <64>;
>           interrupt-parent = <&intc>;
>           reg = <0x48060000 0x1000>;
>           status = "disabled";
>        };
>
> The probe succeeds but I still get a "Waiting for root device
> /dev/mmcblk0p2" when booting over MMC.

Hi Joel,

Can you share your branch with edma + 3.11 cleanup, so that I can reproduce this
issue.

>
> If you're planning to push the cleanup branch, can we temporarily add
> the hwmod data back while we work on this issue so that upstream MMC
> is kept working.
>
> Thanks,
>
> -Joel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

