From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/4] ARM: OMAP2+: Fix AM335x RTC External Abort
Date: Fri, 22 Jul 2016 11:41:30 +0300
Message-ID: <5791DC3A.6070808@ti.com>
References: <20160712175034.743-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160712175034.743-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Olof Johansson <olof@lixom.net>, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On 12/07/16 20:50, Dave Gerlach wrote:
> Hi,
> With next-20160711 there is an external abort during boot on am335x
> platforms from the RTC which is caused by commit 183e2077d007 ("ARM:
> AM33xx: fix module_wait_ready without clkctrl register"), log is here [1].
> The RTC hwmod is unique in that it has a clkctrl_offs of 0 which is
> invalid normally, all other hwmods have non-zero offsets. Because of this,
> we need to flag the hwmod so 0 actually gets used for the offset
> instead of the just returning 0 and doing nothing.
>
> This series adds a HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET flag and moves the check
> for validity of the clkctrl_offs value to the omap_hwmod code so that we are
> able to check both the flag and clkctrl_offs values. This code is shared by
> all OMAP4+ platforms but shoudl have no affect for anything but RTC on
> am335x but still boot tested on the following platforms:

Series looks good to me, so:

Acked-by: Tero Kristo <t-kristo@ti.com>

-Tero

>
> AM335x GP EVM:		Pass http://pastebin.ubuntu.com/19186160/
> Beaglebone Black:	Pass http://pastebin.ubuntu.com/19186862/
> AM437x GP EVM:		Pass http://pastebin.ubuntu.com/19186555/
> OMAP4 Panda ES:		Pass http://pastebin.ubuntu.com/19186711/
> OMAP5 uEVM:		Pass http://pastebin.ubuntu.com/19186925/
>
> Regards,
> Dave
>
> [1] https://storage.kernelci.org/next/next-20160711/arm-omap2plus_defconfig/lab-baylibre-seattle/boot-am335x-boneblack.html
>
> Dave Gerlach (4):
>    ARM: OMAP4+: hwmod: Add hwmod flag for HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET
>    ARM: OMAP2+: AM33XX: Add HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET flag to rtc
>      hwmod
>    ARM: OMAP4+: Have _omap4_wait_target_* check for valid clkctrl_offs
>    ARM: OMAP4+: CM: Remove redundant checks for clkctrl_offs of zero
>
>   arch/arm/mach-omap2/cm33xx.c                            | 6 ------
>   arch/arm/mach-omap2/cminst44xx.c                        | 6 ------
>   arch/arm/mach-omap2/omap_hwmod.c                        | 8 ++++++++
>   arch/arm/mach-omap2/omap_hwmod.h                        | 4 ++++
>   arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 2 ++
>   5 files changed, 14 insertions(+), 12 deletions(-)
>
