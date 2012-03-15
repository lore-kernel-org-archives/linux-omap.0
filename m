From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: I2C: always compile I2C reset code,
 even if I2C driver is not built
Date: Thu, 15 Mar 2012 09:56:27 -0700
Message-ID: <20120315165626.GX12083@atomide.com>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
 <E1S87xA-0000N4-2z@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33516 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030760Ab2COQ4a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 12:56:30 -0400
Content-Disposition: inline
In-Reply-To: <E1S87xA-0000N4-2z@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120315 03:33]:
> During kernel init, we reset all IP blocks on the OMAP that we can,
> even if there is no driver compiled for that IP block.  Unlike most IP
> blocks, the I2C block requires some extra programming for this to
> work.  This reset code is incorrectly omitted when the I2C driver is
> deselected.  In this circumstance, the build breaks.  Fix by compiling
> the I2C reset code unconditionally.

This one is commit ed8dfd22ea2533a1b169881c3de94be8daa0e297 in
arm-soc/for-next.

Regards,

Tony
