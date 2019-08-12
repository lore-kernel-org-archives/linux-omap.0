From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 02/22] ARM: omap1: make omapfb standalone compilable
Date: Mon, 12 Aug 2019 11:21:05 +0200
Message-ID: <9b2b4623-f1cb-0e50-691e-e18f8f864c8f@samsung.com>
References: <20190808212234.2213262-1-arnd@arndb.de>
        <CGME20190808212453epcas2p44ff418662ee1acf428c6842ee4488f9f@epcas2p4.samsung.com>
        <20190808212234.2213262-3-arnd@arndb.de>
        <55c9608d-68c4-17f6-2682-7668d5d7720a@samsung.com>
        <CAK8P3a3grFEGr33s327yNMabK5=1kCJc3k7y55dhzQx9sTvkyQ@mail.gmail.com>
        <487da98d-a862-0207-289a-bca8ff18e51a@samsung.com>
        <CAK8P3a0_v1XM-fH5TOr-osrdLOsfYGbG8VCqktuSgUU7jKtgNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0_v1XM-fH5TOr-osrdLOsfYGbG8VCqktuSgUU7jKtgNQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: linux-omap@vger.kernel.org


On 8/9/19 9:55 PM, Arnd Bergmann wrote:
> On Fri, Aug 9, 2019 at 4:36 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> On 8/9/19 1:43 PM, Arnd Bergmann wrote:
> 
>>>
>>> That would have been ok as well, but having the addition here was
>>> intentional and seems more logical to me as this is where the headers
>>> get moved around.
>> I see that this is an optimization for making the patch series more
>> compact but I think that this addition logically belongs to patch #9
>> (which adds support for COMPILE_TEST) where the new code is required.
>>
>> Moreover patch description for patch #2 lacks any comment about this
>> addition being a preparation for changes in patch #9 so I was quite
>> puzzled about its purpose when seeing it first.
>>
>> Therefore please have mercy on the poor/stupid reviewer and don't do
>> such optimizations intentionally (or at least describe them properly
>> somewhere).. ;-)
> 
> Ok, I looked at it some more and agree that you are right. I've split it
> up further now into patches that make more sense by themselves:
> 
> commit ad71cdc54404ecde2e88678ee6bc7ae7fb8aec97
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Aug 6 16:08:34 2019 +0200
> 
>     fbdev: omap: avoid using mach/*.h files
> 
>     All the headers we actually need are now in include/linux/soc,
>     so use those versions instead and allow compile-testing on
>     other architectures.
> 
>     Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
>  drivers/video/backlight/Kconfig          | 4 ++--
>  drivers/video/backlight/omap1_bl.c       | 4 ++--
>  drivers/video/fbdev/omap/Kconfig         | 4 ++--
>  drivers/video/fbdev/omap/lcd_ams_delta.c | 2 +-
>  drivers/video/fbdev/omap/lcd_dma.c       | 3 ++-
>  drivers/video/fbdev/omap/lcd_inn1510.c   | 2 +-
>  drivers/video/fbdev/omap/lcd_osk.c       | 4 ++--
>  drivers/video/fbdev/omap/lcdc.c          | 2 ++
>  drivers/video/fbdev/omap/omapfb_main.c   | 3 +--
>  drivers/video/fbdev/omap/sossi.c         | 1 +
>  10 files changed, 16 insertions(+), 13 deletions(-)
> 
> commit 959e0d68751757e84dd703f60405c7268763dba4
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri Aug 9 21:27:01 2019 +0200
> 
>     fbdev: omap: pass irqs as resource
> 
>     To avoid relying on the mach/irqs.h header, stop using
>     OMAP_LCDC_IRQ and INT_1610_SoSSI_MATCH directly in the driver
>     code, but instead pass these as resources.
> 
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
>  arch/arm/mach-omap1/fb.c               | 19 ++++++++++++++++++-
>  drivers/video/fbdev/omap/lcdc.c        |  6 +++---
>  drivers/video/fbdev/omap/omapfb.h      |  2 ++
>  drivers/video/fbdev/omap/omapfb_main.c | 16 +++++++++++++++-
>  drivers/video/fbdev/omap/sossi.c       |  2 +-
>  5 files changed, 39 insertions(+), 6 deletions(-)
> 
> 
> commit 6643f7a7da3ca7ce8f2ff094fecab7a0fd706acf
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri Aug 9 21:42:31 2019 +0200
> 
>     ARM: omap1: declare a dummy omap_set_dma_priority
> 
>     omapfb calls directly into the omap_set_dma_priority() function in
>     the DMA driver. This prevents compile-testing omapfb on other
>     architectures. Add an inline function next to the other ones
>     for non-omap configurations.
> 
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
>  include/linux/omap-dma.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> commit 154bfb7ddcecdbca66d9a086776a3108831ef0b9
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Mon Aug 5 23:15:37 2019 +0200
> 
>     ARM: omap1: move lcd_dma code into omapfb driver
> 
>     The omapfb driver is split into platform specific code for omap1, and
>     driver code that is also specific to omap1.
> 
>     Moving both parts into the driver directory simplifies the structure
>     and avoids the dependency on certain omap machine header files.
> 
>     As mach/lcd_dma.h can not be included from include/linux/omap-dma.h
>     any more now, move the omap_lcd_dma_running() declaration into the
>     omap-dma header, which matches where it is defined.
> 
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
>  arch/arm/mach-omap1/Makefile
>    |  4 ----
>  arch/arm/mach-omap1/include/mach/lcdc.h
>    | 44 --------------------------------------------
>  drivers/video/fbdev/Makefile
>    |  2 +-
>  drivers/video/fbdev/omap/Makefile
>    |  5 +++++
>  {arch/arm/mach-omap1 => drivers/video/fbdev/omap}/lcd_dma.c
>    |  4 +++-
>  {arch/arm/mach-omap1/include/mach =>
> drivers/video/fbdev/omap}/lcd_dma.h |  2 --
>  drivers/video/fbdev/omap/lcdc.c
>    |  2 +-
>  drivers/video/fbdev/omap/lcdc.h
>    | 35 +++++++++++++++++++++++++++++++++++
>  drivers/video/fbdev/omap/sossi.c                                         |  1 +
>  include/linux/omap-dma.h
>    |  4 ++--
>  10 files changed, 48 insertions(+), 55 deletions(-)
> 
> commit b8ddb98d29a43fecb4387d0d8218935cb1997a28
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Aug 6 14:59:00 2019 +0200
> 
>     ARM: omap1: innovator: pass lcd control address as pdata
> 
>     To avoid using the mach/omap1510.h header file, pass the correct
>     address as platform data.
> 
>     Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
>  arch/arm/mach-omap1/board-innovator.c  | 3 +++
>  drivers/video/fbdev/omap/lcd_inn1510.c | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

Thank you for reworking the patch series.

> The resulting code is the same as before, I'll post that again along
> the rest of the series next week. Should I add your Ack to each
> patch already?

Yes, please do.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
