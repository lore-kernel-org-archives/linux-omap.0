From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 00/15] voltdm cleanup + auto-ret / auto-off support
Date: Fri, 25 Nov 2011 17:49:33 +0200
Message-ID: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47900 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab1KYPt5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:49:57 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFnvIB031639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:49:57 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFnvme005477
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:49:57 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFnvWD017424
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:49:57 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

Hi,

Changes compared to previous version:

- merged most of the voltagedomain cleanup fixes to patch 2
- moved pmic latencies to omap_voltdm_pmic struct
- renamed omap_lp_params to omap2_oscillator as it only contains
  osc info now
- major changes to usecount support (patch 11+, needed for auto-ret)
  * added usecounts to voltagedomain / powerdomain
  * fixed usecount tracking so that the numbers are sane now
  * changed behavior of some usecounting sources that they do not
    update the counts (autoidle support)
- added auto-ret / auto-off support, based on fixed usecounting
  * smartreflex disabled / enabled
  * auto-ret / auto-off enabled based on target state
- some other minor tweaks I have probably forgotten to mention

Tested on omap3 beagle:
- voltages for vdd1 and vdd2 change when entering idle
- both suspend and dynamic idle tested
- tested that voltages reach target levels for both ret / off

Tested on omap4 blaze with custom kernel
- this requires a few additional patches missing from this set as
  omap4 PM support is still not merged
- will post missing patches once possible from upstream point of view
- voltages for vdd1 and vdd3 change when entering idle

Applies on top of Kevin's for_3.2/voltage-cleanup branch.

I have a bunch of additional debugging patches I have used in verification
of this set if anybody is interested.

TBD:
- no pmic off support yet
  * no pmic script support
  * vdd1 / vdd2 only reach 0.6V, not 0V in off
  * oscillator is not turned off

-Tero


