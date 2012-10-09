From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] ARM: sort select statements alphanumerically
Date: Tue, 9 Oct 2012 14:18:25 +0800
Message-ID: <CAGsJ_4zi1GNOAVW3dVrwHkjQEWrVTkNvpiq1R-=GVvN5VC-weA@mail.gmail.com>
References: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Daniel Walker <dwalker@fifo99.com>, Kevin Hilman <khilman@ti.com>, linux-samsung-soc@vger.kernel.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, David Brown <davidb@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alessandro Rubini <rubini@unipv.it>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, spear-devel@list.st.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Kukjin Kim <kgene.kim@samsung.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Andrew Victor <linux@maxim.org.za>linux
List-Id: linux-omap@vger.kernel.org

2012/10/7 Russell King <rmk+kernel@arm.linux.org.uk>:
> As suggested by Andrew Morton:
>
>   This is a pet peeve of mine.  Any time there's a long list of items
>   (header file inclusions, kconfig entries, array initalisers, etc) and
>   someone wants to add a new item, they *always* go and stick it at the
>   end of the list.
>   ...
>   Guys, don't do this.  Either put the new item into a randomly-chosen
>   position or, probably better, alphanumerically sort the list.
>
>   For this reason it looks like approximately 0% of the patchset will
>   apply, sorry.
>
> lets sort all our select statements alphanumerically.  This commit was
> created by the following script:
>
> #!/usr/bin/perl
> while (<>) {
>         while (/\\\s*$/) {
>                 $_ .= <>;
>         }
>         undef %selects if /^\s*config\s+/;
>         if (/^\s+select\s+(\w+).*/) {
>                 if (defined($selects{$1})) {
>                         if ($selects{$1} eq $_) {
>                                 print STDERR "Warning: removing duplicated $1 entry\n";
>                         } else {
>                                 print STDERR "Error: $1 differently selected\n".
>                                         "\tOld: $selects{$1}\n".
>                                         "\tNew: $_\n";
>                                 exit 1;
>                         }
>                 }
>                 $selects{$1} = $_;
>                 next;
>         }
>         if (%selects and (/^\s*$/ or /^\s+help/)) {
>                 foreach $k (sort (keys %selects)) {
>                         print "$selects{$k}";
>                 }
>                 undef %selects;
>         }
>         print;
> }
> if (%selects) {
>         foreach $k (sort (keys %selects)) {
>                 print "$selects{$k}";
>         }
> }
>
> It found two duplicates:
>
> Warning: removing duplicated S5P_SETUP_MIPIPHY entry
> Warning: removing duplicated HARDIRQS_SW_RESEND entry
>
> and they are identical duplicates, hence the shrinkage in the diffstat
> of two lines.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Changes in CSR prima2 arch look fine,

Acked-by: Barry Song <Baohua.Song@csr.com>

BTW, i have a bundle of patches coming for new Marco platform which
will also change the Kconfig.

> ---
> This commit is likely to change as we get closer to the end of the merge
> window, as other changes get merged into Linus' tree.  I will be refreshing
> this from time to time, and keeping it out of linux-next, as it will cause
> more pain than its worth to put it into linux-next.
>
> Anyone who wants to give this a review to check that it's correct are welcome,
> but I don't think it would be appropriate to collect attributation tags for
> it, as this won't be the final patch.
>
> This patch is intentionally broken to prevent Linus from applying it - this
> is information only!
>
> Anyone who wants to apply it can do so by first running this patch through:
>
>         sed 's/^-- /@@ /'
>
>  arch/arm/Kconfig                  |  399 ++++++++++++++++++-------------------
>  arch/arm/common/Kconfig           |    4 +-
>  arch/arm/mach-at91/Kconfig        |   26 ++--
>  arch/arm/mach-clps711x/Kconfig    |    4 +-
>  arch/arm/mach-davinci/Kconfig     |   16 +-
>  arch/arm/mach-exynos/Kconfig      |  181 +++++++++---------
>  arch/arm/mach-footbridge/Kconfig  |    8 +-
>  arch/arm/mach-h720x/Kconfig       |    2 +-
>  arch/arm/mach-imx/Kconfig         |  120 ++++++------
>  arch/arm/mach-ixp4xx/Kconfig      |    2 +-
>  arch/arm/mach-mmp/Kconfig         |    6 +-
>  arch/arm/mach-msm/Kconfig         |   28 ++--
>  arch/arm/mach-nomadik/Kconfig     |    4 +-
>  arch/arm/mach-omap1/Kconfig       |    8 +-
>  arch/arm/mach-omap2/Kconfig       |   68 +++---
>  arch/arm/mach-prima2/Kconfig      |    2 +-

-barry
