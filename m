From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V6 0/6] OMAPDSS: Cleanup cpu_is checks
Date: Wed, 22 Aug 2012 12:06:53 +0530
Message-ID: <cover.1345616887.git.cmahapatra@ti.com>
References: <cover.1345468541.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58628 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab2HVGlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Aug 2012 02:41:39 -0400
In-Reply-To: <cover.1345468541.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
this patch series aims at cleaning up of DSS of cpu_is checks thereby making it
more generic.

The 1st patch cleans up cpu_is checks from DISPC code.
The 2nd patch removes unused functions from DSS code.
The 3rd patch cleans up cpu_is checks from DSS code.
The 4th patch disables VENC support on OMAP4.
The 5th patch removes cpu_is checks from VENC code.
The 6th patch removes cpu_is checks from DPI code and replaces it with a
dss feature.

Changes from V1 to V5 series:
 1st patch :
	* moved dispc_ops structure definitions from dss_features.c to dispc.c
	  and renamed it to dispc_features
	* moved dispc_features definitions close to dispc_init_features() thereby
	  eliminating various functions declarations from top of dispc.c
	* used __initconst before dispc_features definitions and __init before
	  dispc_init_features()
	* removed definitions of _dispc_lcd_timings_ok_24xx,
	  _dispc_lcd_timings_ok_44xx, _dispc_mgr_set_lcd_timings_hv_24xx and
	  _dispc_mgr_set_lcd_timings_hv_44xx replacing them with appropiate variables
	* renamed various dispc_features structures to give consistent naming

 3rd patch :
	* moved dss_ops structure definitions from dss_features.c to dss.c and
	  renamed it to dss_features
	* removed all functions from dss_features structure and replaced them with
	  appropiate variables
	* used __initconst before dss_features definitions and __init before 
	  dss_init_features()
	* renamed various dss_features structures to give consistent naming
	* renamed factor variable of dss_features structure to dss_fck_multiplier

Changes from V5 to V6 series:
	* The "ARM: OMAP: Disable venc for OMAP4" patch has been placed before
	  "OMAPDSS: VENC: Remove cpu_is_xxxx checks" patch
 1st patch:
	* The dispc_init_features() implementation has been corrected
	* The variables types of variables in dispc_features has been changed
	  to u8 and u16 as found appropiate
 2nd patch:
	* The dss_init_features() implementation has been corrected
	* In dss_features struct char * has been changed to const char * and
	  int replaced with u8

All your comments and suggestions are welcome.

Refenence Tree:
git@gitorious.org:~chandrabhanu/linux-omap-dss2/chandrabhanus-linux.git dss_cleanup

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (6):
  OMAPDSS: DISPC: Cleanup cpu_is_xxxx checks
  OMAPDSS: DSS: Remove redundant functions
  OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
  ARM: OMAP: Disable venc for OMAP4
  OMAPDSS: VENC: Remove cpu_is_xxxx checks
  OMAPDSS: DPI: Remove cpu_is_xxxx checks

 arch/arm/mach-omap2/display.c          |    1 -
 drivers/video/omap2/dss/dispc.c        |  434 ++++++++++++++++++++------------
 drivers/video/omap2/dss/dpi.c          |   12 +-
 drivers/video/omap2/dss/dss.c          |  165 ++++++------
 drivers/video/omap2/dss/dss.h          |    2 -
 drivers/video/omap2/dss/dss_features.c |    1 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/venc.c         |   11 -
 8 files changed, 367 insertions(+), 260 deletions(-)

-- 
1.7.10

