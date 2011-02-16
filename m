From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] omap4: 4430sdp: drop ehci support
Date: Wed, 16 Feb 2011 13:26:31 +0200
Message-ID: <20110216112631.GA2497@legolas.emea.dhcp.ti.com>
References: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58699 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754761Ab1BPL0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 06:26:36 -0500
Received: by mail-bw0-f48.google.com with SMTP id 8so1550961bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 03:26:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keshava Munegowda <keshava_mgowda@ti.com>, Tony Lindgren <tony@atomide.com>

On Wed, Feb 16, 2011 at 04:47:19PM +0530, Anand Gadiyar wrote:
> Most revisions of the OMAP4 Blaze/SDP platform do not have
> the EHCI signals routed by default. The pads are routed
> for the alternate HSI functionality instead, and explicit
> board modifications are needed to route the signals to
> the USB PHY on the board.
> 
> Also, turning on the PHY connected to the EHCI port causes
> a board reboot during bootup due to an unintended short
> on the rails - this affects many initial revisions of the
> board, and needs a minor board mod to fix (or as a
> workaround, one should not attempt to power on the
> USB PHY).
> 
> Given that these boards need explicit board mods to even
> get EHCI working (separate from the accidental short above),
> we should not attempt to enable EHCI by default.
> 
> So drop the EHCI support from the board files for the
> Blaze/SDP platforms.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Keshava Munegowda <keshava_mgowda@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Tony, if you want to queue this one directly, here's my:

Acked-by: Felipe Balbi <balbi@ti.com>

if you wish, I can send you a pull request as well. I already have
another patch for you anyway.

-- 
balbi
