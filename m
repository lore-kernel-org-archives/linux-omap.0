From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: omap2: fix am43xx build without L2X0
Date: Thu, 5 Apr 2018 11:07:09 +0200
Message-ID: <CAK8P3a113KzqRU7_qY96YGTz28+hMuyrMvJJVxOcL7cJogkpKQ@mail.gmail.com>
References: <20180404102550.3692501-1-arnd@arndb.de> <20180404171222.GH5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404171222.GH5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>, Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 4, 2018 at 7:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Arnd Bergmann <arnd@arndb.de> [180404 10:27]:
>> When CONFIG_CACHE_L2X0 is disabled, the am43xx specific suspend
>> implemnentation fails to link:
>>
>> arch/arm/mach-omap2/sleep43xx.o: In function `get_l2cache_base':
>> (.text+0x180): undefined reference to `omap4_get_l2cache_base'
>>
>> This adds an #ifdef protection around the code, like we do for am44xx.
>>
>> Fixes: 41d37e61372f ("ARM: OMAP2+: Introduce low-level suspend code for AM43XX")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks, looks OK to me:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied to next/soc.

     Arnd
