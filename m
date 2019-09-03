From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/4] soc changes for omap variants for v5.4
Date: Tue, 3 Sep 2019 14:25:29 +0200
Message-ID: <CAK8P3a2ox-G7238GZmJjxEb1Q-yc9RvQ541xwSKpdqaF+Y_NmQ@mail.gmail.com>
References: <pull-1567016893-318461@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1567016893-318461@atomide.com>
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

On Wed, Aug 28, 2019 at 8:35 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/soc-signed
>
> for you to fetch changes up to 50f57ef83d836d727902a6a7e70cca61b0d02655:
>
>   ARM: OMAP2+: Delete an unnecessary kfree() call in omap_hsmmc_pdata_init() (2019-08-26 08:59:48 -0700)
>
> ----------------------------------------------------------------
> SoC changes for omap variants for v5.4
>
> The first change moves platform-specific asm-offsets.h to arch/arm/mach-omap2
> to fix iessu with parallel build with CONFIG_IKHEADERS, and the second change
> removes a useless kfree.
>
> Note that the first change causes a trivial merge conflict with the iommu
> changes for arch/arm/mach-omap2/Makefile.

Pulled into arm/soc, thanks!

      Arnd
