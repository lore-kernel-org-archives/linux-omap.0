From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu-wdt: Fix bitfield access
Date: Thu, 3 Mar 2011 11:43:25 +0200
Message-ID: <20110303094325.GH2644@legolas.emea.dhcp.ti.com>
References: <1299082313.13604.13.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34527 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754756Ab1CCJna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 04:43:30 -0500
Received: by bwz13 with SMTP id 13so1534918bwz.1
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 01:43:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299082313.13604.13.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Mar 02, 2011 at 05:11:53PM +0100, Michael Buesch wrote:
> An unsigned int pointer must not be casted to an unsigned
> long pointer before use. Convert the bitfield to unsigned long
> to fix this.
> Also use clear_bit() in the release path.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

This looks ok, I'm just wondering if the change on test_and_set_bit()
from bit 1 to bit 0 should be on this patch. I guess not.

-- 
balbi
