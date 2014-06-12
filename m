From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 0/5] Handle non-secure L2C initialization on Exynos4
Date: Thu, 12 Jun 2014 16:13:40 +0200
Message-ID: <5399B594.2040205@samsung.com>
References: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Robin Holt <holt@sgi.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Daniel,

On 12.06.2014 15:38, Daniel Drake wrote:
> Hi Tomasz,
> 
> Thanks for working on this!
> 
> I have just tried this, against Linus master
> 64b2d1fbbfda07765dae3f601862796a61b2c451.
> Added patch "ARM: dts: Initial ODROID U2 support" and booted on
> ODROID-U2. I believe this board has the security enabled.
> 
> Unfortunately, it hangs during early boot. With earlyprintk the last
> messages seen are:
> 
> L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
> L2C: platform provided aux values permit register corruption.
> L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
> L2C-310 enabling early BRESP for Cortex-A9
> L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> L2C-310 ID prefetch enabled, offset 1 lines
> L2C-310 dynamic clock gating enabled, standby mode enabled
> L2C-310 cache controller enabled, 16 ways, 1024 kB
> L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001
> 

Thanks for testing. We have some ODROIDs U2 and U3 here too so I'll try
to reproduce and investigate the issue.

> I then tried to go back to the earlier patch "ARM: EXYNOS: Add secure
> firmware support for l2x0 init" (attached, needed a rebase) but that
> one also now hangs at:
> 
> L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
> 
> It did work on 3.14 though. Looking at the changelogs, many changes
> have been made to l2x0 recently. Can you confirm that you have tested
> your patches against a kernel with all of Russell King's recent
> changes?

I'm usually working on latest linux-next, so I'm pretty sure all the
mentioned patches were already in my tree. The base for this series was
next-20140610 tag of linux-next tree.

Best regards,
Tomasz
