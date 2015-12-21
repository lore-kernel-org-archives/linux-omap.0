From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mtd: onenand: omap2: Simplify the DMA setup for various
 paths
Date: Mon, 21 Dec 2015 10:09:37 +0200
Message-ID: <5677B3C1.9070500@ti.com>
References: <1450086572-15224-1-git-send-email-peter.ujfalusi@ti.com>
 <20151218181111.GK10460@google.com> <20151218183948.GO23396@atomide.com>
 <20151219133049.GA1611@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151219133049.GA1611@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
Cc: Brian Norris <computersforpeace@gmail.com>, kyungmin.park@samsung.com, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/19/2015 03:30 PM, Aaro Koskinen wrote:
> Probably DMA support is not that critical. Looks like with DT boot it=
's
> not even possible to enable it at the moment.

I think by adding 'dma-channel' property is there to enable the DMA mod=
e via DT.

As for stripping out the DMA support: I'm fine with that if no one obje=
cts,
but in the header of the file we have:
 *  Author: Jarkko Lavinen <jarkko.lavinen@nokia.com> and Juha Yrj=F6l=E4
 *  IRQ and DMA support written by Timo Teras

So I believe the DMA and IRQ code was a big stunt itself to receive it'=
s own
line there...

--=20
P=E9ter
