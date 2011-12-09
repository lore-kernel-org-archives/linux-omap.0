From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 0/5] SMPS regulator driver
Date: Fri, 9 Dec 2011 17:29:44 +0200
Message-ID: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab1LIP36 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 10:29:58 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pB9FTv1K000326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:57 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTvHv000564
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:57 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTvrI018677
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:57 -0600 (CST)
Received: from localhost.localdomain (h88-4.vpn.ti.com [172.24.88.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTtvB006466	for
 <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:56 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Sorry I've been busy with other stuff lately, thus the update took
some time. Anyway, changes compared the previous version:

- changed driver_data format that is being passed from board to
  twl-regulator, this also required tweaking twl-core so that the
  data gets passed through correctly
- dropped one patch from the set as it was pushed for integration
  already:
  [PATCHv7 1/7] regulator: twl: fix twl4030 support for smps regulators
- some other minor tweaks

-Tero

