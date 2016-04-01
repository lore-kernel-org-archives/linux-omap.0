From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] enable dm814x and dra62x clock driver for v4.6 merge
 window
Date: Fri, 1 Apr 2016 08:48:02 -0700
Message-ID: <20160401154801.GL9329@atomide.com>
References: <20160303231031.GH4469@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160303231031.GH4469@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd & Olof,

* Tony Lindgren <tony@atomide.com> [160303 15:12]:
> The following changes since commit 8a8b6eb7a87f12804f44128d6e4c59b19f224308:
> 
>   clk: ti: Fix some errors found by static checkers (2016-03-01 16:21:25 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/dt-ti81xx-signed
> 
> for you to fetch changes up to 5d7e23a79444385d03717dc19cc58dd2d5883052:
> 
>   ARM: dts: Add clocks for dm814x ADPLL (2016-03-01 17:14:22 -0800)
> 
> ----------------------------------------------------------------
> Enable dm814x and dra62x clock driver. This branch has a dependency
> to the clk-ti branch from the Linux clk tree for the ADPLL clock driver.
> Otherwise things won't keep booting properly when we flip over to use
> the clock driver instead of fixed clocks set up by the bootloader.
> 
> ----------------------------------------------------------------
> Tony Lindgren (1):
>       ARM: dts: Add clocks for dm814x ADPLL
> 
>  arch/arm/boot/dts/dm814x-clocks.dtsi | 243 ++++++++++++++++++++++++++++++-----
>  arch/arm/boot/dts/dra62x-clocks.dtsi |  26 ++++
>  2 files changed, 238 insertions(+), 31 deletions(-)

Looks like this patch is still missing. It has been in Linux next
for close to a month now, and the clock dependency is now merged.
And I believe this fixes booting on hp t410 for some firmware versions.

So it would be good to have this merged during the early -rc cycle.

Regards,

Tony
