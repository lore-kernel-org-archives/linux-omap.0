From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH 0/5] Handle non-secure L2C initialization on Exynos4
Date: Tue, 17 Jun 2014 12:45:51 +0100
Message-ID: <CAD8Lp47AHrwSx52Oi98HN51_L2pwT2xco9WB0FFP1rUdEucfZw@mail.gmail.com>
References: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
	<539B11EB.6010304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <539B11EB.6010304@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Robin Holt <holt@sgi.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jun 13, 2014 at 3:59 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> I have attached, three patches which make the kernel boot fine with L2
> cache enabled on ODROID-U3. Could you test them on your setup to verify
> that they indeed fix the issue?

Nice work, now my ODROID-U2 boots fine.

L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
L2C: platform provided aux values permit register corruption.
L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
L2C-310 enabling early BRESP for Cortex-A9
L2C-310: enabling full line of zeros but not enabled in Cortex-A9
L2C-310 ID prefetch enabled, offset 8 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001

Thanks!
Daniel
