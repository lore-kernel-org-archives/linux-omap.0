From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 3/3] OMAP3: PM: Wakeup from TWL4030 keypad with OFF mode
Date: Fri, 5 Feb 2010 13:36:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E259DEEC@dbde02.ent.ti.com>
References: <87r5p01xg2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53290 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0BEIHH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 03:07:07 -0500
In-Reply-To: <87r5p01xg2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, February 05, 2010 3:22 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/3] OMAP3: PM: Wakeup from TWL4030 
> keypad with OFF mode
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > This patch allows wakeup from TWL4030 keypad when
> > OFF mode is hit during suspend.
> >
> > Tested on OMAP3EVM.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> 
> The idea here looks good, but there is nothing realy EVM specific here
> AFAICT, and this exact code could be used on any other board using
> the T2 keypad, right?  How about a common location?

[sp] The EVM uses SYS_NIRQ for hooking up with the T2 keypad. Not
     sure of everyone would be doing so. Also, PADCONFs are more
     applicable for OMAP3, but T2 can be used with other processors
     as well...

     I did initially inplement these functions in:
     drivers/input/keyboard/twl4030_keypad.c

     ...but then moved to board specific file.

> 
> Also, after looking at this patch, I think the 'void *pstate' member
> of struct twl4030_keypad_data should be renamed to 'void *data' to
> be more clear that it's just a pointer.

[sp] Will make the change. However, will wait for your response on the
     earlier comment before re-submit.

~sanjeev

> 
> Kevin
> 
> 

[snip]--[snip]
