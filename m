From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 0/6] common clk framework
Date: Tue, 13 Dec 2011 19:53:52 -0800
Message-ID: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>

The common clk framework is an attempt to define a generic struct clk
which most platforms can use to build a clk tree and perform a set of
well-defined operations.

The previous patchset, v3, can be found at,
http://article.gmane.org/gmane.linux.kernel/1218622

New stuff in v4:
 * clk rate change notifiers
 * clk debug info via debugfs (instead of sysfs)
 * lots of bug fixes

Stuff that is known to be missing in v4:
 * basic mux and divider clk types
 * fix for migrating clk_prepare_count/clk_enable_count in
   clk_set_parent
 * minor rework comments from v3
 * Documentation/clk.txt needs love

All of the mising items above will be rolled into v5 ASAP.  I wanted to
go ahead and push out the new notifier changes for review and gather
comments on those since those were a big gap in the v3 patchset.

Paul W. also had some good comments about the greater clk API, and the
opportunity to fix some of that stuff while this patchset is still under
discussion.  I didn't address those here because they require more
thought, and more comments from reviewers.

Finally, OMAP4 support for the common struct clk will be posted
immediately after this patch series to LAKML and LOML, along with some
hack patches that show how to use the recursive clk_set_rate for
propagating rate changes up the tree for CPUfreq and how to use the new
clk rate change notifiers in a driver.

Mike Turquette (6):
  clk: Kconfig: add entry for HAVE_CLK_PREPARE
  Documentation: common clk API
  clk: introduce the common clock framework
  clk: introduce rate change notifiers
  clk: basic gateable and fixed-rate clks
  clk: export the clk tree topology to debugfs

 Documentation/clk.txt   |  312 +++++++++++++++
 drivers/clk/Kconfig     |   23 ++
 drivers/clk/Makefile    |    4 +-
 drivers/clk/clk-basic.c |  208 ++++++++++
 drivers/clk/clk.c       |  992 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h     |  230 +++++++++++-
 6 files changed, 1765 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/clk.txt
 create mode 100644 drivers/clk/clk-basic.c
 create mode 100644 drivers/clk/clk.c

-- 
1.7.5.4
