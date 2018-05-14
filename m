From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] one bug fix and other omap fixes for v4.17-rc cycle
Date: Mon, 14 May 2018 01:04:12 -0700
Message-ID: <20180514080412.e2d7djqhj6yuy5qx@localhost>
References: <pull-1525967831-865303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1525967831-865303@atomide.com>
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

On Thu, May 10, 2018 at 09:00:26AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit fb289e3ab10c16834741bb02be740fa9d025fde0:
> 
>   Merge branch 'omap-for-v4.17/fixes-ti-sysc' into omap-for-v4.17/fixes (2018-04-19 15:48:46 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v17/fixes-rc4
> 
> for you to fetch changes up to 41bd6adf3c5d3990d7a67639aff53d54483744fa:
> 
>   Revert "ARM: dts: logicpd-som-lv: Fix pinmux controller references" (2018-05-07 08:28:17 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omap variants for v4.17
> 
> This series of patches contains one BUG fix for trace if
> CONFIG_DEBUG_PREEMPT is enabled and a regression fix for omap1 FIQ
> handling on ams-delta. Then there's a dts fix for missing SoC
> compatible on ti81xx board dts files that did matter until we added
> the clkctrl clocks and without that some clocks are now not found.
> 
> Then there are two logicpd-som-lv specific dts fixes that fix
> misconfigured pins for WLAN and audio. Turns out we had to revert
> the third one because it caused another regression for USB.

Merged, thanks.


-Olof
