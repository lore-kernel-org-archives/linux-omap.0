From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: board-generic: Remove un-needed
 .atag_offset for DT_MACHINE
Date: Wed, 15 Feb 2012 10:13:13 -0800
Message-ID: <20120215181313.GY1426@atomide.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
 <20120214195249.GS1426@atomide.com>
 <4F3BAFCD.2000508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45917 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab2BOSNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 13:13:16 -0500
Content-Disposition: inline
In-Reply-To: <4F3BAFCD.2000508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [120215 04:43]:
> On 2/14/2012 8:52 PM, Tony Lindgren wrote:
> >* Benoit Cousson<b-cousson@ti.com>  [120213 07:59]:
> >>Some .atag_offset entries were wrongly added during a merge conflict
> >>resolution in 3.3.
> >>Remove them all, since DT boot does not use that attribute anymore.
> >>
> >>Replace as well the #if... by #ifdef for consistency.
> >
> >How about let's also remove the 0x from the serial@0x.. in the .dts
> >files in this clean-up patch?
> 
> In the same patch?
> 
> I'm fine with fixing that as well, but since this is not in the same
> file / directory, I'd rather do a different patch.
> 
> I'll do the fix anyway, it is up to you for the proper location.

OK separate patch is fine with me.

Tony
