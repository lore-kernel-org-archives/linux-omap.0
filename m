From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] ARM: omap2: Fix build when using split object directories
Date: Thu, 12 Apr 2018 18:08:58 +0900
Message-ID: <CAK7LNAQiq-4daX2K4dPyzN7zr+yfkQWSJ-yy9JHgacPpYFp94w@mail.gmail.com>
References: <20180411211543.7923-1-d-gerlach@ti.com> <20180412082157.GB4002@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412082157.GB4002@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>
List-Id: linux-omap@vger.kernel.org

2018-04-12 17:21 GMT+09:00 Anders Roxell <anders.roxell@linaro.org>:
> On 2018-04-11 16:15, Dave Gerlach wrote:
>> The sleep33xx and sleep43xx files should not depend on a header file
>> generated in drivers/memory. Remove this dependency and instead allow
>> both drivers/memory and arch/arm/mach-omap2 to generate all macros
>> needed in headers local to their own paths.
>>
>> This fixes an issue where the build fail will when using O= to set a
>> split object directory and arch/arm/mach-omap2 is built before
>> drivers/memory with the following error:
>>
>> .../drivers/memory/emif-asm-offsets.c:1:0: fatal error: can't open drivers/memory/emif-asm-offsets.s for writing: No such file or directory
>> compilation terminated.
>>
>> Fixes: 41d9d44d7258 ("ARM: OMAP2+: pm33xx-core: Add platform code needed for PM")
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
>
> Maybe we can remove drivers/memory/Makefile.asm-offsets and move those
> changes into drivers/memory/Makefile ?

Agree!




-- 
Best Regards
Masahiro Yamada
