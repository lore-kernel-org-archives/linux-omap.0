From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 0/12] McBSP cleanup and generalization
Date: Fri,  1 Jul 2011 11:52:24 +0300
Message-ID: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab1GAIwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:52:55 -0400
Received: by bwd5 with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:52:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi

Some cleanups to McBSP code and attempts to make it more generic. I'll be out
of office in coming days but I'm happy to hear how does this set work on
OMAP1 Amstrad Delta as there are changes around register definitions and
access. I've tested this on 2420 and 3430 and build tested with omap1_defconfig
and omap2plus_defconfig.

I added Paul's build fix first as it seems to got lost in l-o master during
recent devel branch merges and my patches are made on top of it. Paul's
patch can be found from commit 7150dfee80a1e7ed5064730994b704495a8c6b99.

For is_omap removal I didn't invent any other new than reg_size and reg_step
to platform data but in the future I think mcbsp_config_type is better to
replace with some feature flags that come from hwmod so that there is no
need to modify code for any new omap version.

Long term plan is still bit open. If we go to merge McBSP with ASoC omap-mcbsp
we can drop quite much of special API here as well as omap-mcbsp-dai
platform devices.

-- 
Jarkko
