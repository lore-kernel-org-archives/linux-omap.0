From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Fri, 27 May 2011 12:38:21 -0700
Message-ID: <87oc2ox7bm.fsf@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
	<1306375016-707-4-git-send-email-nm@ti.com> <87oc2p82q0.fsf@ti.com>
	<4DDF4E4D.6060008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52518 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756470Ab1E0TiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 15:38:24 -0400
Received: by mail-pz0-f54.google.com with SMTP id 27so1162877pzk.41
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 12:38:23 -0700 (PDT)
In-Reply-To: <4DDF4E4D.6060008@ti.com> (Benoit Cousson's message of "Fri, 27
	May 2011 09:10:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

[...]

> In general we do not want to reset nor idle an IP that was potentially
> already properly configured by bootloader or early Linux boot code.

Actually, the opposite is true.

The kernel should not make any assumptions about what the bootloader has
or has not done.  We need to have a kernel that can boot from any
bootloader (or none, like using kexec) and be able to start from a known
hardware state.

Any use of HWMOD_INIT_NO_IDLE, HWMOD_INIT_NO_RESET should be a rare
exception and well documented.

Kevin
