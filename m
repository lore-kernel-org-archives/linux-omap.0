From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition info
Date: Sun, 24 Mar 2019 20:24:48 +0100
Message-ID: <454BF5C9-478A-4E2A-BF00-D2A2AFE25C45@goldelico.com>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <20190320011630.GB7872@darkstar.musicnaut.iki.fi> <2631901.52Nzq63B5o@z50> <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 24.03.2019 um 19:59 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
>=20
> Hi,
>=20
> On Sun, Mar 24, 2019 at 05:48:22PM +0100, Janusz Krzysztofik wrote:
>> Hi Aaro,
>>=20
>> Thanks for your review.
>>=20
>> On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
>>> On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
>>>> After recent modifications, only a hardcoded partition info makes
>>>> the driver device specific.  Other than that, the driver uses GPIO
>>>> exclusively and can be used on any hardware.
>>>>=20
>>>> Drop the partition info and use MTD partition parser with default
>>>> list of partition types instead.
>>>>=20
>>>> Amstrad Delta users should append the followig partition info to =
their
>>>                                        ^^^^^^^^
>>> Should be "following".
>>>=20
>>>> kernel command line, possibly by embedding it in CONFIG_CMDLINE:
>>>> =
mtdparts=3Dams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\=

>>>> 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
>>>> convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that =
board
>>>> Kconfig automatically if this NAND driver is also selected.
>>>>=20
>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>=20
>>> Could we move the fixed partition setup to the board file
>>> instead? Otherwise this kind of change is not really nice for the =
users,
>>> as it will likely break existing setups. The default partition =
layout
>>> should remain the same.
>>=20
>> I'm wondering if it would be acceptable to pass partition info from a =
.dts=20
>> file.  I think that would be a better, more modern approach than =
adding a new=20
>> header under include/linux/platform_data.
>=20
> Hmm, I thought there was some generic way to define partitions without
> adding any new headers. But if that is not possible, then I guess your
> CMDLINE proposal is the preferred one..

I am not sure what you exactly need, but partitions can be defined in
the DTS as children of some NAND drivers. Example:
arch/arm/boot/dts/omap3-beagle.dts
So this design pattern could be copied instead of using CMDLINE.
