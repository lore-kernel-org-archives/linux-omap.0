From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/4] soc changes for omaps for v4.21
Date: Fri, 30 Nov 2018 15:51:07 -0800
Message-ID: <20181130235107.wvtp52bdbs33feky@localhost>
References: <pull-1543521343-338334@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1543521343-338334@atomide.com>
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

On Thu, Nov 29, 2018 at 11:57:40AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/soc-signed
> 
> for you to fetch changes up to b76455335447fa8b73ebc0ca768e46ee74fcd329:
> 
>   ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h> (2018-11-19 10:06:36 -0800)
> 
> ----------------------------------------------------------------
> SoC changes for omaps for v4.21 merge window
> 
> Few more non-critical section annotation fixes for Clang and
> remove obsolete timer header inclusion.
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h>
> 
> Nathan Chancellor (2):
>       ARM: OMAP2+: hwmod: Fix some section annotations
>       ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Merged, thanks!


-Olof
