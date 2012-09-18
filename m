From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Tue, 18 Sep 2012 12:57:32 +0300
Message-ID: <5058458C.5010908@ti.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de> <1347368390-31252-13-git-send-email-arnd@arndb.de> <504F4227.4080206@ti.com> <201209121720.33822.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201209121720.33822.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>, Grant Likely <grant.likely@secretlab.ca>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On 09/12/2012 08:20 PM, Arnd Bergmann wrote:
> On Tuesday 11 September 2012, Peter Ujfalusi wrote:
>> OMAP McBSP has nothing to do with a dsp.
>> A better name would be: ti-mcbsp.h (or leave it as mcbsp.h)
>> McBSP stands for: Multichannel Buffered Serial Port and it is used f=
or audio
>> connection (I2S, TDM, etc).
>=20
> changed to asoc-ti-mcbsp.h to, as discussed.
>=20
>>>  .../include/plat/dsp.h =3D> include/linux/platform_data/dsp-omap.h=
   |    0
>>>  .../plat/keypad.h =3D> include/linux/platform_data/keypad-omap.h  =
   |    0
>>>  .../plat/lcd_mipid.h =3D> include/linux/platform_data/lcd-mipid.h =
   |    0
>>>  .../plat/nand.h =3D> include/linux/platform_data/mtd-nand-omap2.h =
   |    0
>>>  .../onenand.h =3D> include/linux/platform_data/mtd-onenand-omap2.h=
   |    0
>>>  .../remoteproc.h =3D> include/linux/platform_data/remoteproc-omap.=
h  |    0
>>>  .../voltage.h =3D> include/linux/platform_data/smartreflex-omap.h =
   |    0
>>>  .../plat/mcspi.h =3D> include/linux/platform_data/spi-omap2-mcspi.=
h  |    0
>>>  include/linux/power/smartreflex.h                                 =
 |    2 +-
>>
>> Let me see these:
>>
>> This four drivers are going to be removed via sound tree.
>>>  sound/soc/omap/igep0020.c                                         =
 |    2 +-
>>>  sound/soc/omap/omap3beagle.c                                      =
 |    2 +-
>>>  sound/soc/omap/omap3evm.c                                         =
 |    2 +-
>>>  sound/soc/omap/overo.c                                            =
 |    2 +-
>>
>> The new driver which replaces these (omap-twl4030.c) does not includ=
e
>> plat/mcbsp.h
>=20
> For the sake of bisection, I think we should leave the patch as is.
> When merging the two branches, we will get a small conflict that
> is trivial to resolve.
>=20
>> From these ASoC machine drivers you can just remove the <plat/mcbsp.=
h>
>> include since they should not include them (I have pending patch for=
 this to
>> be sent):
>>>  sound/soc/omap/am3517evm.c                                        =
 |    2 +-
>>>  sound/soc/omap/ams-delta.c                                        =
 |    2 +-
>>>  sound/soc/omap/n810.c                                             =
 |    2 +-
>>>  sound/soc/omap/omap3pandora.c                                     =
 |    2 +-
>>>  sound/soc/omap/osk5912.c                                          =
 |    2 +-
>>>  sound/soc/omap/rx51.c                                             =
 |    2 +-
>>>  sound/soc/omap/sdp3430.c                                          =
 |    2 +-
>>>  sound/soc/omap/zoom2.c                                            =
 |    2 +-
>>
>>>  sound/soc/omap/omap-mcbsp.c                                       =
 |    2 +-
>>>  sound/soc/omap/mcbsp.c                                            =
 |    2 +-
>=20
> Can you do that change on top of mine? I would prefer to leave it as =
is
> because I could create this version with a script.
>=20
> The alternative is that I leave the mcbsp.h file alone entirely and y=
ou
> submit a patch to fix all instances where it's used, either rename or
> remove them.

I thought I have replied to this...
Whichever way you prefer. I can craft a series to clean up the plat/mcb=
sp.h
usage and move the mcbsp header via ASoC tree.
I'm also fine if you do the move.
Let me know what you prefer.

Thanks,
P=C3=A9ter
