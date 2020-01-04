From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [BISECTED, REGRESSION] OMAP3 onenand/DMA broken
Date: Sat, 4 Jan 2020 09:38:31 +0200
Message-ID: <7a8f4222-9815-9dd8-e13c-9d2e57cfb1ea@ti.com>
References: <20200103081726.GD15023@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200103081726.GD15023@darkstar.musicnaut.iki.fi>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On 1/3/20 10:17 AM, Aaro Koskinen wrote:
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
> 
> Bisected to:
> 
> 4689d35c765c696bdf0535486a990038b242a26b is the first bad commit
> commit 4689d35c765c696bdf0535486a990038b242a26b
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Tue Jul 16 11:24:59 2019 +0300
> 
>     dmaengine: ti: omap-dma: Improved memcpy polling support
> 
> The commit does not revert cleanly anymore. Any ideas how to fix this?

I certainly tested the memcpy via dmatest in polled and non polled mode..

I can take a look on Tuesday earliest, but sent a patch (untested) which
should fix the issue:
https://lore.kernel.org/lkml/20200104073453.16077-1-peter.ujfalusi@ti.com/


> 
> A.
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
