From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 0/3] spi: omap2-mcspi: driver updates
Date: Sat, 31 Mar 2012 17:06:55 +0530
Message-ID: <1333193818-3984-1-git-send-email-shubhrajyoti@ti.com>
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
Cc: Shubhrajyoti, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch series does the following cleanups
- Makes the driver use autosuspend
- Folds Benoit's bus_num removal patch in the series
- The tmp variable is used to write this can be optimised 
 as it is not needed if the value is directly written.
 Acknowledge  Tarun for the suggestion.

This is also available through
git     : git://gitorious.org/linus-tree/linus-tree.git
branch  : spi_next

Rebased to Grant's spi/next branch.

 

Benoit Cousson (1):
  spi/omap: Remove bus_num usage for instance index

Shubhrajyoti D (2):
  spi: omap2-mcspi: add support for pm_runtime autosuspend
  spi: omap2-mcspi: Trivial optimisation

 drivers/spi/spi-omap2-mcspi.c |   86 +++++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 45 deletions(-)


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
