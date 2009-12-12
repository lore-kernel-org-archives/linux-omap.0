From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 00/10 V5] omap3: pm: introduce support for 3630 OPPs
Date: Fri, 11 Dec 2009 23:00:28 -0600
Message-ID: <1260594031-17268-1-git-send-email-nm@ti.com>
References: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142AbZLLFAa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Dec 2009 00:00:30 -0500
In-Reply-To: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Hi,
Thanks for all the comments. Here are the *changed* patches since V5

What changed in V5:
* review comment incorporated
* vsel is deprecated now
* I seem to have hit a checkpatch.pl bug as in 
  http://lkml.org/lkml/2009/12/11/573, made me check the usage
  of __deprecated for struct params, and used it in a
  consistent manner to functions..
* More warnings added to build :( (deprecated ones ofcourse)
* removed OMAP_OPP_DEF_TERMINATOR
* 3430 and 3630 patches changed as a result

History:
V4: http://marc.info/?t=126033962600001&r=1&w=2
V3: http://marc.info/?t=125912234200001&r=1&w=2
V2: http://marc.info/?l=linux-omap&m=125809232732700&w=2
V1: http://marc.info/?l=linux-omap&m=125800488923479&w=2

Ref: http://elinux.org/OMAP_Power_Management#Future_directions

TODO: The list is still the same as in:
http://marc.info/?l=linux-omap&m=126033945313269&w=2

Regards,
Nishanth Menon
