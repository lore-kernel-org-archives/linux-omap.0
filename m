From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: DRA7: Update to latest TRM and cleanup
Date: Fri, 10 Jun 2016 09:18:16 -0500
Message-ID: <CAGo_u6okpNGkfYno02nCfEsryki5drrhfwnZUj=ycghh62qoTg@mail.gmail.com>
References: <1464096940-27145-1-git-send-email-nm@ti.com> <20160610093359.GQ22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160610093359.GQ22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 10, 2016 at 4:34 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Nishanth Menon <nm@ti.com> [160524 06:37]:
>> Hi,
>>
>> Here are the final(hopefully) pending patches for DRA7 based on recent
>> TRM updates. Updates include removing retention support on L3init and
>> L4per as per latest SoC updates.
>>
>> Test Log: X15 (no modules): http://pastebin.ubuntu.com/16655027/
>>
>> Latest TRM (rev F): http://www.ti.com/lit/pdf/spruhz6 (public on May 18)
>>
>> Nishanth Menon (3):
>>   ARM: OMAP: DRA7: powerdomain data: Set L3init and L4per to ON
>>   ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_logic_ret
>>   ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret
>>
>>  arch/arm/mach-omap2/powerdomains7xx_data.c | 76 +-----------------------------
>>  1 file changed, 2 insertions(+), 74 deletions(-)
>
> Can these wait until v4.8 merge window, are this needed as fixes to
> avoid hardware problems?

Yes - at least patch #1 is a h/w "limitation" and can result in non
functional SoC after a duration of operation. the patches #2/3 are
code shrinkage to remove unused data.

-- 
---
Regards,
Nishanth Menon
