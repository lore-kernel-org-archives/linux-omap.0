From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] fixes for omap variants for v5.3-rc cycle
Date: Thu, 15 Aug 2019 14:39:56 +0200
Message-ID: <CAK8P3a0Ynmu1X+Y6Ba6UP9gfyJddhFj3ZfF5vA45nZgOdfn8fQ@mail.gmail.com>
References: <pull-1565844391-332885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1565844391-332885@atomide.com>
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
Cc: SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 15, 2019 at 6:49 AM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.3/fixes-rc4
>
> for you to fetch changes up to 4a65bbb9109ed7edd4b6ed7168ced48abb8561a2:
>
>   soc: ti: pm33xx: Make two symbols static (2019-08-13 05:05:38 -0700)
>
> ----------------------------------------------------------------
> Fixes for omap variants for v5.3-rc cycle
>
> We have another fix to disable voltage switching for am57xx SDIO as
> the bootrom cannot handle all the voltages after a reset that thought
> I had already sent a pull request for earlier but forgot. And we also
> update dra74x iodelay configuration for mmc3 to use the recommended
> values.
>
> Then I noticed we had introduced few new boot warnings with the various
> recent ti-sysc changes and wanted to fix those. I also noticed we still
> have too many warnings to be able to spot the real ones easily and fixed
> up few of those. Sure some of the warnings have been around for a long
> time and few of the fixes could have waited for the merge window, but
> having more usable dmesg log level output is a valuable.
>
> Other fixes are IO size correction for am335x UARTs that cause issues
> for at least FreeBSD using the same device tree file that checks that
> the child IO range is not larger than the parent has.
>
> For omap1 ams-delta keyboard we need to fix a irq ack that broke with
> all the recent gpio changes.
>
> And there are also few static checker warning fixes for recent am335x
> PM changes and ti-sysc driver and one switch fall-though update.

Pulled into fixes, thanks!

     Arnd
