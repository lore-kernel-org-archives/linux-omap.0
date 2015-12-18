From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mtd: onenand: omap2: Simplify the DMA setup for various
 paths
Date: Fri, 18 Dec 2015 21:48:09 +0200
Message-ID: <567462F9.1010703@ti.com>
References: <1450086572-15224-1-git-send-email-peter.ujfalusi@ti.com>
 <20151218181111.GK10460@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151218181111.GK10460@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: kyungmin.park@samsung.com, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 12/18/2015 08:11 PM, Brian Norris wrote:
> On Mon, Dec 14, 2015 at 11:49:32AM +0200, Peter Ujfalusi wrote:
>> We have 4 functions containing almost identical DMA setup code. Crea=
te one
>> function which can set up the DMA for both read and write and use th=
is in
>> place for the setup code in the driver.
>> The new function will use wait_for_completion_timeout() and it will =
figure
>> out the best data_type to be used for the transfer instead of hardwi=
ring
>> 32 or 16 bit data.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> Does anyone use this driver? I've seen practically zero activity on t=
he
> entire OneNAND codebase in the last few years, and I presumed it was
> essentially dead.
>=20
> If it's not dead, I'd like to know some contingency of people who are
> willing to actually maintain (or at least review) this stuff.
>=20
> Kyungmin, are you still out there? Or Tony, do you know of any users =
for
> this?
>=20
> Peter, are you actually using this, or are you just refactoring for t=
he
> fun of it?

Not really for fun, but I want to get rid of all legacy/direct sDMA use=
 so at
the end we will have omap_start_dma() visible in two files:
arch/arm/plat-omap/dma.c
drivers/dma/omap-dma.c

from there it will be possible to get rid of the plat-omap code. This o=
nenand
driver was the first in the 'git grep omap_start_dma' result ;)

--=20
P=E9ter
