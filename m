From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 05/06][omapzoom] BRIDGE: Fix header path name to
 "arch/arm/plat-omap/include/dspbridge"
Date: Sat, 20 Sep 2008 09:10:12 +0300 (EEST)
Message-ID: <20080920.091012.233900997.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5344B3DCD7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49893 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYITGKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2008 02:10:20 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5344B3DCD7@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com
Cc: vikram.pandita@ti.com, linux-omap@vger.kernel.org

Hi Omar,

From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 05/06][omapzoom] BRIDGE: Fix header path name to "arch/arm/plat-omap/include/dspbridge"
Date: Fri, 19 Sep 2008 21:07:53 -0500

> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Date: Fri, 19 Sep 2008 19:18:15 -0500
> Subject: [PATCH] BRIDGE: Fix header path name to "arch/arm/plat-omap/include/dspbridge"
> 
> sed -i -e \
> 's@arch/arm/plat-omap/include/bridge@arch/arm/plat-omap/include/dspbridge@g' \
> drivers/dsp/bridge/Kbuild \
> drivers/dsp/bridge/*/*.[ch] \
> arch/arm/plat-omap/include/dspbridge/*.h
> 
> - * dspbridge/inc/chnl_sm.h
> + * dsplinux/arch/arm/plat-omap/include/dspbridge//chnl_sm.h

It seems that you ran the wrong script;)

Also it may be better that the paths are omitted as David Brownell
suggested in another mail.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04551.html

	Hiroshi DOYU

