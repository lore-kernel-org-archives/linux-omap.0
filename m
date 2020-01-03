From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED, REGRESSION] OMAP3 onenand/DMA broken
Date: Fri, 3 Jan 2020 19:23:27 +0200
Message-ID: <20200103172326.GF15023@darkstar.musicnaut.iki.fi>
References: <20200103081726.GD15023@darkstar.musicnaut.iki.fi>
 <6D46CA13-2E50-4144-86F1-CE4988BD654D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6D46CA13-2E50-4144-86F1-CE4988BD654D@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jan 03, 2020 at 09:46:58AM +0100, H. Nikolaus Schaller wrote:
> > Am 03.01.2020 um 09:17 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
> > When booting v5.4 (or v5.5-rc4) on N900, the console gets flooded with:
> > 
> > [    8.335754] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.365753] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.395751] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.425750] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.455749] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.485748] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.515777] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.545776] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > [    8.575775] omap2-onenand 1000000.onenand: timeout waiting for DMA
> > 
> > making the system unusable.
> 
> I can confirm that this issue exists but so far we failed to bisect
> and make a proper report.
> 
> Sometimes the system boots fine and sometimes it fails.
> 
> It happens on omap3-gta04a5one.dts only, but not with omap3-gta04a4.dts
> (both dm3730 but different NAND).

I tried three different boards (N810, N900 and N950) and it always
fails reliably.

A.
