From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu: Add locking around register access in irq
 handler
Date: Mon, 28 Feb 2011 21:09:31 +0200
Message-ID: <20110228190931.GS2459@legolas.emea.dhcp.ti.com>
References: <1298909168.16391.6.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:49454 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752886Ab1B1TJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 14:09:35 -0500
Received: by mail-bw0-f48.google.com with SMTP id 8so5105931bwz.35
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 11:09:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298909168.16391.6.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, Feb 28, 2011 at 05:06:08PM +0100, Michael Buesch wrote:
> This adds locking around the register access in the
> interrupt service routine.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
> Reported-by: Felipe Balbi <balbi@ti.com>

Fine by me. Tony, you can apply.

-- 
balbi
