From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 0/5] OMAP: iommu: hwmod, reset handling and runtime PM
Date: Mon, 19 Nov 2012 19:05:47 -0600
Message-ID: <1353373552-16039-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

These patches are needed for remoteproc to work on OMAP4.

Introduced iommu hwmod support for OMAP3 (iva, isp) and
OMAP4 (ipu, dsp), along with the corresponding runtime PM
and routines to deassert reset lines, enable/disable clocks
and configure sysc registers.

A couple of patches were added (first two) to be clearer on
the reasons for such changes, they were previosuly bundled as part
of runtime PM changes. The last patch corresponds to a change in the
leaf clocks used and it depends on this series to work properly.

Due to single Image support, I rebased these on top of k3.7-rc5 and
DEPEND on:

[PATCH v5 0/6] Move rest of omap-iommu to live in drivers/iommu
http://thread.gmane.org/gmane.linux.kernel/1387788

Minor rebasing might be needed if these are included on top of
linux-omap, since they are affected by changes on headers being
moved to include/linux/platform_data and arch/arm/mach-omap2.

Omar Ramirez Luna (5):
  iommu/omap: remove redundant clock handling on ISR
  iommu/omap: keep mmu enabled when requested
  iommu/omap: migrate to hwmod framework
  iommu/omap: adapt to runtime pm
  ARM: OMAP4: hwmod data: ipu and dsp to use parent clocks instead of
    leaf clocks

 arch/arm/mach-omap2/clock44xx_data.c       |   22 ----
 arch/arm/mach-omap2/devices.c              |    2 +-
 arch/arm/mach-omap2/omap-iommu.c           |  167 ++++++---------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +-
 drivers/iommu/omap-iommu.c                 |   68 ++++++-----
 drivers/iommu/omap-iommu.h                 |    3 -
 drivers/iommu/omap-iommu2.c                |   36 ------
 include/linux/platform_data/iommu-omap.h   |    9 +-
 8 files changed, 84 insertions(+), 227 deletions(-)

-- 
1.7.4.1
