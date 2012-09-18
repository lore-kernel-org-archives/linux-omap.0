From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP_DEBUG_LEDS needs to select LEDS_CLASS
Date: Tue, 18 Sep 2012 16:02:03 +0800
Message-ID: <CAK5ve-L92DqDv7ZApaaN5BOby+oPf2Ate-3jvgkadm7gfXZLcg@mail.gmail.com>
References: <1347939042.15578.1.camel@phoenix> <CAK5ve-LXv76vuBLHQQtREHn_ZogUsbyqzz2-uTHT_Ps-9vS3Pw@mail.gmail.com>
 <CAF+7xWnJj4XovwT5K_BDN8Q4GBLogsCb29Ro9t0Taek95HaPDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF+7xWnJj4XovwT5K_BDN8Q4GBLogsCb29Ro9t0Taek95HaPDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axel.lin@gmail.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 18, 2012 at 2:49 PM, Axel Lin <axel.lin@gmail.com> wrote:
> 2012/9/18 Bryan Wu <bryan.wu@canonical.com>:
>> On Tue, Sep 18, 2012 at 11:30 AM, Axel Lin <axel.lin@gmail.com> wrote:
>>> This fixes below build error when CONFIG_LEDS_CLASS is not set.
>>>
>>>   LD      init/built-in.o
>>> arch/arm/plat-omap/built-in.o: In function `fpga_probe':
>>> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
>>> make: *** [vmlinux] Error 1
>>>
>>
>> Thanks for posting this. But I think Tony has already fixed it in mainline:
>> --
>> commit 359f64f7b3997e94ee71039b5fcdc1278b9b77c4
>> Author: Tony Lindgren <tony@atomide.com>
>> Date:   Wed Sep 15 10:18:51 2010 -0700
>>
>>     omap: Fix compile dependency to LEDS_CLASS
>>
>>     If we LEDS_CLASS is not selected, we will get undefined reference
>>     to `led_classdev_register'.
>>
>>     Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Commit 359f64f7b was commited on Sep 15 2010.
> This patch is against current linux-next tree.
> I got the build error on linux-next tree (next-20120917).
>

Obviously, linux-next is not updated to latest mainline, -:D

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.186-168-78255 Mobile
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
