From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] few minor omap fixes against v4.4-rc6
Date: Tue, 22 Dec 2015 13:24:51 -0800
Message-ID: <20151222212451.GG30172@localhost>
References: <20151221205418.GD2793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151221205418.GD2793@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 21, 2015 at 12:54:19PM -0800, Tony Lindgren wrote:
> The following changes since commit 14054fb1da099fd89208b8b319a00e0b902c7645:
> 
>   ARM: dts: am4372: fix clock source for arm twd and global timers (2015-12-09 16:46:25 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/fixes-rc6
> 
> for you to fetch changes up to 0b4d6972d7b052b23d33ff9bdbb52958664fbb26:
> 
>   ARM: dts: Fix UART wakeirq for omap4 duovero parlor (2015-12-18 16:43:22 -0800)
> 
> ----------------------------------------------------------------
> Few fixes for omaps to allow am437x only builds to boot properly with
> CPU_IDLE and ARM TWD timer. This is probably a common configuration setup
> for people making products with these SoCs so let's make sure it works.
> 
> Also a wakeirq fix for duovero parlor making my life a bit easier as that
> allows me to run basic PM regression tests on it.
> 
> It would be nice to have these in v4.4, but if it gets too late for that
> because of the holidays, it is not super critical if these get merged for
> v4.5.
> 

Merged into fixes for v4.4.


Thanks,

-Olof
