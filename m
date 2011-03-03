From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: [PATCH] cbus-retu-wdt: Fix bitfield access
Date: Thu, 03 Mar 2011 15:21:29 +0100
Message-ID: <1299162089.31972.4.camel@maggie>
References: <1299082313.13604.13.camel@marge>
	 <20110303094325.GH2644@legolas.emea.dhcp.ti.com>
	 (sfid-20110303_104339_778071_FFFFFFFFC2E683EE)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:45693 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab1CCOVe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 09:21:34 -0500
In-Reply-To: <20110303094325.GH2644@legolas.emea.dhcp.ti.com> (sfid-20110303_104339_778071_FFFFFFFFC2E683EE)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, 2011-03-03 at 11:43 +0200, Felipe Balbi wrote: 
> On Wed, Mar 02, 2011 at 05:11:53PM +0100, Michael Buesch wrote:
> > An unsigned int pointer must not be casted to an unsigned
> > long pointer before use. Convert the bitfield to unsigned long
> > to fix this.
> > Also use clear_bit() in the release path.
> > 
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> 
> This looks ok, I'm just wondering if the change on test_and_set_bit()
> from bit 1 to bit 0 should be on this patch. I guess not.

Uh, well. If that's worth doing a separate patch, I'll do it.
It doesn't actually really matter if we use bit 0, 1 or ... for this.
I just thought it was weird to use the second bit.

-- 
Greetings Michael.

