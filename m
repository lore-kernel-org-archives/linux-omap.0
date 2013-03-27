From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/26] DSS device model change
Date: Wed, 27 Mar 2013 13:25:25 -0700
Message-ID: <20130327202525.GJ10155@atomide.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
 <20130326171006.GG25575@atomide.com>
 <51528E1F.9080608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27226 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754114Ab3C0UZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 16:25:27 -0400
Content-Disposition: inline
In-Reply-To: <51528E1F.9080608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130326 23:18]:
> On 2013-03-26 19:10, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [130326 06:38]:
> >> Note about board files: I only convert a few board files here for example. I
> >> have a branch with board file changes for all the affected board files. I did
> >> not include them as they are more or less identical. If this series looks good,
> >> I will create an independent branch for the arch/arm stuff, so it can be pulled
> >> separately.
> > 
> > Great looks good to me thanks.
> 
> To make the DSS work properly after this device model change, we also
> need to solve the problem related to multiple display devices on the
> same video bus.
> 
> Did the approach I suggested in
> 
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/96039
> 
> look ok? Overo is the most complex one, I think the rest of the boards
> that require changes have just LCD and DVI that conflict. But it still
> means we'll have that kind of choice Kconfig option for all those boards.

Yes I think that's the best way to go until we just drop the board-*.c
files in favor of device tree.

Regards,

Tony
