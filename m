From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3+: SR: ensure pm-runtime callbacks can be invoked with IRQ disabled
Date: Mon, 11 Jul 2011 11:53:09 -0700
Message-ID: <877h7ozm22.fsf@ti.com>
References: <1310247441-2709-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47243 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757636Ab1GKSxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 14:53:16 -0400
Received: by mail-iy0-f172.google.com with SMTP id 7so4802755iye.31
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 11:53:15 -0700 (PDT)
In-Reply-To: <1310247441-2709-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 9 Jul 2011 14:37:21 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Tony,

Nishanth Menon <nm@ti.com> writes:

> SmartReflex should be disabled while entering low power mode due to
> a) SmartReflex values are not defined for retention voltageFurther
> b) with SmartReflex enabled, if CPU enters lower c-states, FSM will try
> to bump the voltage to current OPP's voltage for which it has entered c-state;
> hence SmartReflex needs to be disabled for MPU, CORE and IVA voltage
> domains in idle path before enabling auto retention voltage achievement
> on the device.

This should go in for v3.1 also.

I made some minor changelog edits and put in my for_3.0/pm-fixes-3
branch.

Kevin
