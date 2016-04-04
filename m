From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2: Make suspend work again.
Date: Mon, 4 Apr 2016 11:17:24 +0530
Message-ID: <5701FFEC.5020008@ti.com>
References: <1459551187-5992-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459551187-5992-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Saturday 02 April 2016 04:23 AM, Nishanth Menon wrote:
> Hi,
> series of patches for fixing up attempt to suspend on X15
>
> Test: http://pastebin.ubuntu.com/15582436/
>
> Based on v4.6-rc1
>
> Also needs https://patchwork.kernel.org/patch/8724791/ if kernel
> modules are installed

Thanks for the series Nishanth.

I tested suspend/resume and used no_console_suspend and woke up using 
uart on DRA7-EVM.

Tested-by: Keerthy <j-keerthy@ti.com>

>
> Nishanth Menon (3):
>    ARM: OMAP: DRA7: wakeupgen: Skip SAR save for wakeupgen
>    ARM: OMAP: DRA7: Provide proper class to omap2_set_globals_tap
>    ARM: OMAP: Catch callers of revision information prior to it being
>      populated
>
>   arch/arm/mach-omap1/id.c             | 1 +
>   arch/arm/mach-omap2/id.c             | 1 +
>   arch/arm/mach-omap2/io.c             | 3 ++-
>   arch/arm/mach-omap2/omap-wakeupgen.c | 7 +++++++
>   4 files changed, 11 insertions(+), 1 deletion(-)
>
