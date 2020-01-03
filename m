From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [BISECTED, REGRESSION] OMAP3 onenand/DMA broken
Date: Fri, 3 Jan 2020 09:46:58 +0100
Message-ID: <6D46CA13-2E50-4144-86F1-CE4988BD654D@goldelico.com>
References: <20200103081726.GD15023@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200103081726.GD15023@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 03.01.2020 um 09:17 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
> 
> Hi,
> 
> When booting v5.4 (or v5.5-rc4) on N900, the console gets flooded with:
> 
> [    8.335754] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.365753] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.395751] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.425750] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.455749] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.485748] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.515777] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.545776] omap2-onenand 1000000.onenand: timeout waiting for DMA
> [    8.575775] omap2-onenand 1000000.onenand: timeout waiting for DMA
> 
> making the system unusable.

I can confirm that this issue exists but so far we failed to bisect
and make a proper report.

Sometimes the system boots fine and sometimes it fails.

It happens on omap3-gta04a5one.dts only, but not with omap3-gta04a4.dts
(both dm3730 but different NAND).

> 
> Bisected to:
> 
> 4689d35c765c696bdf0535486a990038b242a26b is the first bad commit
> commit 4689d35c765c696bdf0535486a990038b242a26b
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Tue Jul 16 11:24:59 2019 +0300
> 
>    dmaengine: ti: omap-dma: Improved memcpy polling support
> 
> The commit does not revert cleanly anymore. Any ideas how to fix this?
> 
> A.

BR, Nikolaus
