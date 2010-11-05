From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2.6.37-rc1] OMAP1: camera.h: readd missing include
Date: Fri, 5 Nov 2010 09:57:53 -0700
Message-ID: <20101105165753.GO9264@atomide.com>
References: <201011021504.03168.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63206 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0KEQ6K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:58:10 -0400
Content-Disposition: inline
In-Reply-To: <201011021504.03168.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101102 06:56]:
> #include <media/omap1_camera.h> directive, required for successfull 
> compilation of dependant boards (board-ams-delta for now), has been lost 
> somehow from arch/arm/mach-omap1/include/mach/camera.h on creation. Readd it.
> 
> Created and tested against linux-2.6.37-rc1.

I've updated the description to use add instead of readd as it
never was there from Linux kernel change log point of view in
the first place:

OMAP1: camera.h: add missing include

#include <media/omap1_camera.h> directive is required to
compile the dependant boards (board-ams-delta for now).

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
[tony@atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>

Also, for the future patches, please always Cc linux-arm-kernel
mailing list as well so I don't have to repost the patches
before merging.

Regards,

Tony
