From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 0/3] spi: omap2-mcspi: spi cleanups
Date: Wed, 22 Aug 2012 11:35:11 +0530
Message-ID: <1345615515-26745-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch does the following

Calls the pm_runtime_* functions directly.
Remove the MOD_REG_BIT macro usage thereby removiing un-needed branch.
At remove dont use the autosuspend runtime calls.

Changes from v1:
Fix the comments on changelogs.
Add acks to the patches.

The following changes since commit 23dcfa61bac244e1200ff9ad19c6e9144dcb6bb5:

  Merge branch 'akpm' (Andrew's patch-bomb) (2012-08-21 17:22:22 -0700)

are available in the git repository at:

  git://gitorious.org/linus-tree/linus-tree.git for_3.6/spi




Shubhrajyoti D (3):
  spi: omap2-mcspi: Call pm_runtime_* functions directly
  spi: omap2-mcspi: Remove the macro MOD_REG_BIT
  spi: omap2-mcspi: At remove dont use the runtime_autosuspend calls

 drivers/spi/spi-omap2-mcspi.c |   55 ++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 31 deletions(-)

-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
