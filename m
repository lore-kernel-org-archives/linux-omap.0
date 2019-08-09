From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 02/22] ARM: omap1: make omapfb standalone compilable
Date: Fri, 9 Aug 2019 16:36:12 +0200
Message-ID: <487da98d-a862-0207-289a-bca8ff18e51a@samsung.com>
References: <20190808212234.2213262-1-arnd@arndb.de>
        <CGME20190808212453epcas2p44ff418662ee1acf428c6842ee4488f9f@epcas2p4.samsung.com>
        <20190808212234.2213262-3-arnd@arndb.de>
        <55c9608d-68c4-17f6-2682-7668d5d7720a@samsung.com>
        <CAK8P3a3grFEGr33s327yNMabK5=1kCJc3k7y55dhzQx9sTvkyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3grFEGr33s327yNMabK5=1kCJc3k7y55dhzQx9sTvkyQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: linux-omap@vger.kernel.org


On 8/9/19 1:43 PM, Arnd Bergmann wrote:
> On Fri, Aug 9, 2019 at 1:32 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> On 8/8/19 11:22 PM, Arnd Bergmann wrote:
>>> The omapfb driver is split into platform specific code for omap1, and
>>> driver code that is also specific to omap1.
>>>
>>> Moving both parts into the driver directory simplifies the structure
>>> and avoids the dependency on certain omap machine header files.
>>>
>>> The interrupt numbers in particular however must not be referenced
>>> directly from the driver to allow building in a multiplatform
>>> configuration, so these have to be passed through resources, is
>>> done for all other omap drivers.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> For fbdev part:
>>
>> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Thanks for taking a look.
> 
>> [ It seems that adding of static inline for omap_set_dma_priority()
>>   when ARCH_OMAP=n should be in patch #9 but this is a minor issue. ]
> 
> That would have been ok as well, but having the addition here was
> intentional and seems more logical to me as this is where the headers
> get moved around.
I see that this is an optimization for making the patch series more
compact but I think that this addition logically belongs to patch #9
(which adds support for COMPILE_TEST) where the new code is required.

Moreover patch description for patch #2 lacks any comment about this
addition being a preparation for changes in patch #9 so I was quite
puzzled about its purpose when seeing it first.

Therefore please have mercy on the poor/stupid reviewer and don't do
such optimizations intentionally (or at least describe them properly
somewhere).. ;-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
