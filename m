From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [STLinux Kernel] [PATCH 49/75] ARM: l2c: fix register naming
Date: Fri, 28 Mar 2014 19:51:19 +0100
Message-ID: <5335C4A7.60904@st.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: Barry Song <baohua@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Anton Vorontsov <anton@enomsg.org>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, spear-devel@list.st.com, Shawn Guo <shawn.guo@linaro.org>, Shiraz Hashim <shiraz.hashim@st.com>, Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-samsung-soc@vger.kernel.org, kernel@stlinux.com
List-Id: linux-omap@vger.kernel.org

Thanks Russel,

On 03/28/2014 04:18 PM, Russell King wrote:
> We have a mixture of different devices with different register layouts,
> but we group all the bits together in an opaque mess.  Split them out
> into those which are L2C-310 specific and ones which refer to earlier
> devices.  Provide full auxiliary control register definitions.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/include/asm/hardware/cache-l2x0.h | 73 ++++++++++++++++++++----------
>   arch/arm/mach-cns3xxx/core.c               |  8 ++--
>   arch/arm/mach-imx/system.c                 |  8 ++--
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c  |  2 +-
>   arch/arm/mach-omap2/omap4-common.c         | 18 ++++----
>   arch/arm/mach-prima2/l2x0.c                |  5 +-
>   arch/arm/mach-realview/realview_pbx.c      |  4 +-
>   arch/arm/mach-spear/spear13xx.c            |  6 +--
>   arch/arm/mach-sti/board-dt.c               |  8 ++--
>   arch/arm/mach-tegra/sleep.h                |  8 ++--
>   arch/arm/mach-ux500/cache-l2x0.c           |  4 +-
>   arch/arm/mach-vexpress/ct-ca9x4.c          |  4 +-
>   arch/arm/mm/cache-l2x0.c                   | 57 +++++++++++------------
>   arch/arm/plat-samsung/s5p-sleep.S          |  8 ++--
>   14 files changed, 118 insertions(+), 95 deletions(-)
>

For the mach-sti part:

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
