From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: board-generic: Remove un-needed
 .atag_offset for DT_MACHINE
Date: Tue, 14 Feb 2012 11:52:50 -0800
Message-ID: <20120214195249.GS1426@atomide.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10220 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757132Ab2BNTww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 14:52:52 -0500
Content-Disposition: inline
In-Reply-To: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [120213 07:59]:
> Some .atag_offset entries were wrongly added during a merge conflict
> resolution in 3.3.
> Remove them all, since DT boot does not use that attribute anymore.
> 
> Replace as well the #if... by #ifdef for consistency.

How about let's also remove the 0x from the serial@0x.. in the .dts
files in this clean-up patch?

Regards,

Tony
