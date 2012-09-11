From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/16] ARM: omap: move platform_data definitions
Date: Tue, 11 Sep 2012 19:54:00 +0530
Message-ID: <CAMQu2gz8F2FcgRuok3x1uJ4pP8=0E2-9jhYGchzU9AUtUHjYhg@mail.gmail.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-1-git-send-email-arnd@arndb.de> <CAMQu2gwLoccyjGwjjgndiW2aR--_S=UhCCTdcav6LicvYWe5SQ@mail.gmail.com>
 <201209111417.42879.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201209111417.42879.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>, Grant Likely <grant.likely@secretlab.ca>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@t>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 7:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 11 September 2012, Shilimkar, Santosh wrote:
>> Just curious to know how you came with some of the above header names ?
>>
>> plat/mcbsp ---> dsp-mcbsp.h
>> There is no connection of DSP with McBSP. "omap-mcbsp.h" would been a
>> better name.
>
> This one was a mistake on my side, as Tony and  Peter already pointed out.
> How about asoc-mcbsp.h or asoc-omap-mcbsp.h?
>
After re-reading the cover-letter and your below response,
'asoc-omap-mcbsp.h' seems to be fine.

>> plat/nand.h --> /mtd-nand-omap2.h
>> plat/onenand.h --> /mtd-onenand-omap2.h
>> May be "omap-nand.h" and "omap-onenand.h"
>>
>> plat/mcspi.h-->spi-omap2-mcspi.h
>> May be "omap-spi.h"
>>
>
> As I wrote in the introductory mail, I tried to always prefix the file
> names with the subsystem, followed by the name of the driver, in order
> to standardize on just one set of rules.
>
Just read that now.

> The drivers implementing the three headers above are:
>
> drivers/mtd/nand/omap2.c
> drivers/mtd/onenand/omap2.c
> drivers/spi/spi-omap2-mcspi.c
>
> so these all seem appropriate.
>
Sorry I missed the subsystem prefix point.
These names seems to be fine then.

Regards
Santosh
