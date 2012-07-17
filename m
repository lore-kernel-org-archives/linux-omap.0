From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: build error with linux-next and omap2plus_defconfig
Date: Tue, 17 Jul 2012 15:31:00 +0530
Message-ID: <500537DC.3030607@ti.com>
References: <50052F0A.3030501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:48256 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752822Ab2GQKBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 06:01:07 -0400
Received: by obcva7 with SMTP id va7so353021obc.20
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 03:01:05 -0700 (PDT)
In-Reply-To: <50052F0A.3030501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 17 July 2012 02:53 PM, Archit Taneja wrote:
> Hi,
>
> The linux-next tree gives this with omap2plus_defconfig:
>
> ...
> ...
> LD init/built-in.o
> drivers/built-in.o: In function `of_clk_get':
> /home/a0393947/source_trees/linux-next/drivers/clk/clkdev.c:42:
> undefined reference to `of_clk_get_from_provider'
> make: *** [vmlinux] Error 1
>
> Any suggestions on how to fix this?

This one should fix it..
http://www.spinics.net/lists/arm-kernel/msg184794.html

>
> Archit
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

