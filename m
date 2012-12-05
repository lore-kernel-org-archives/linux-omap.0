From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 0/6] OMAPDSS: Cleanup omap_dss_features
Date: Wed, 5 Dec 2012 15:46:02 +0530
Message-ID: <cover.1354702077.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45607 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab2LEKTo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 05:19:44 -0500
In-Reply-To: <cover.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
this patch series aims at cleaning up of dss_features.c by moving features to
respective submodule drivers.

The 1st patch
 * moved struct omap_dss_features members burst_size_unit and buffer_size_unit
   to dispc_features
The 2nd patch
 * added definition of struct omapdss_reg_field
 * moved data from dss_reg_fields to dispc_reg_fields
The 3rd patch
 * added definition of struct omapdss_param_range
 * moved data from dss_param_range to dispc_param_ranges
The 4th patch
 * created struct feats and initialized dsi_feats
 * moved data from dss_reg_fields to dsi_reg_fields
 * created dsi_init_features() to initialize dsi_feats
The 5th patch
 * moved data from dss_param_range to dsi_param_range
The 6th patch
 * added members fld_dispc_clk_switch and dss_fck_max to struct dss_features
   and initialized corresponding dss_feats
 * removed definition of dss_reg_field and dss_param_range and their respective
   initializations as omap2_dss_reg_fields, omap3_dss_reg_fields, etc.
 * removed members reg_fields and num_reg_fields from struct omap_dss_features
 * removed enum dss_feat_reg_field and dss_range_param and corresponding
   initializations omap2_dss_param_range, omap3_dss_param_range etc.
 * removed function dss_feat_get_reg_field(), dss_feat_get_param_min() and
   dss_feat_get_param_max()

Changes from V1
 * 1st patch: added comments "in bytes" for new members burst_size_unit and
		buffer_size_unit
 * 2nd patch: renamed register_field to omapdss_reg_field
	      removed definition of enum dispc_feat_reg_field
	      created and initialized struct dispc_reg_fields
 * 3rd patch: renamed struct param_range to omapdss_param_range
	      removed definition of enum dispc_range_param
	      created and initialized struct dispc_param_ranges
 * 4th patch: removed enum dsi_feat_reg_field
	      created and initialized struct dsi_reg_fields
 * 5th patch: removed enum dsi_range_param
	      created and initialized struct dsi_param_ranges
	      added member dss_fck corresponding to FEAT_PARAM_DSS_FCK
 * 6th patch: removed struct dss_param_range and enum dss_range_param
	      removed functions dss_feat_get_param_min() and
			dss_feat_get_param_max()
 * 7th patch has been removed

All your comments and suggestions are welcome.

I have based my patches on git://gitorious.org/linux-omap-dss2/linux.git master

Reference Tree:
git://gitorious.org/linux-omap-dss2/chandrabhanus-linux.git dss_cleanup

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (6):
  OMAPDSS: DISPC: Move burst_size and buffer_size to dispc_features
  OMAPDSS: DISPC: Move DISPC specific dss_reg_fields to dispc_features
  OMAPDSS: DISPC: Move DISPC specific dss_params to dispc_features
  OMAPDSS: DSI: Move DSI specific reg_fields to dsi_feats
  OMAPDSS: DSI: Move DSI specific dss_params to dsi_feats
  OMAPDSS: DSS: Add members fld_dispc_clk_switch and dss_fck_max

 drivers/video/omap2/dss/dispc.c        |  218 +++++++++++++++++++++++---------
 drivers/video/omap2/dss/dsi.c          |  206 ++++++++++++++++++++++++++----
 drivers/video/omap2/dss/dss.c          |   22 +++-
 drivers/video/omap2/dss/dss.h          |    8 ++
 drivers/video/omap2/dss/dss_features.c |  212 -------------------------------
 drivers/video/omap2/dss/dss_features.h |   36 ------
 6 files changed, 368 insertions(+), 334 deletions(-)

-- 
1.7.10

