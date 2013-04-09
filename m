From: Tony Lindgren <tony@atomide.com>
Subject: 4430sdp nfsroot broken with ff5c9059
Date: Tue, 9 Apr 2013 14:23:18 -0700
Message-ID: <20130409212318.GR10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56413 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935429Ab3DIVXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 17:23:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

Hi Jon,

Looks like at least 4430sdp nfsroot got broken with commit
ff5c9059 (ARM: dts: OMAP3+: Correct gpio #interrupts-cells
property).

Do we need to pass the GPIO edge/level info now?

Regards,

Tony
