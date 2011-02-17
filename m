From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] omap4: 4430sdp: drop ehci support
Date: Thu, 17 Feb 2011 09:47:06 +0200
Message-ID: <20110217074706.GD2439@legolas.emea.dhcp.ti.com>
References: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
 <20110216112631.GA2497@legolas.emea.dhcp.ti.com>
 <20110217014210.GL20795@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55939 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877Ab1BQHrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 02:47:12 -0500
Received: by bwz10 with SMTP id 10so2298756bwz.34
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 23:47:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110217014210.GL20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keshava Munegowda <keshava_mgowda@ti.com>

On Wed, Feb 16, 2011 at 05:42:10PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110216 03:25]:
> > On Wed, Feb 16, 2011 at 04:47:19PM +0530, Anand Gadiyar wrote:
> > > Most revisions of the OMAP4 Blaze/SDP platform do not have
> > > the EHCI signals routed by default. The pads are routed
> > > for the alternate HSI functionality instead, and explicit
> > > board modifications are needed to route the signals to
> > > the USB PHY on the board.
> > > 
> > > Also, turning on the PHY connected to the EHCI port causes
> > > a board reboot during bootup due to an unintended short
> > > on the rails - this affects many initial revisions of the
> > > board, and needs a minor board mod to fix (or as a
> > > workaround, one should not attempt to power on the
> > > USB PHY).
> > > 
> > > Given that these boards need explicit board mods to even
> > > get EHCI working (separate from the accidental short above),
> > > we should not attempt to enable EHCI by default.
> > > 
> > > So drop the EHCI support from the board files for the
> > > Blaze/SDP platforms.
> > > 
> > > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > > Cc: Keshava Munegowda <keshava_mgowda@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > 
> > Tony, if you want to queue this one directly, here's my:
> > 
> > Acked-by: Felipe Balbi <balbi@ti.com>
> > 
> > if you wish, I can send you a pull request as well. I already have
> > another patch for you anyway.
> 
> OK if you have more I'd rather pull.

ok. Taken.

-- 
balbi
