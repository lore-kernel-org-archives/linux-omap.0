From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH RFC] MUSB: Fix index register corruption seen with
	g_ether and Windows host
Date: Wed, 6 Aug 2008 13:47:33 +0300
Message-ID: <20080806104733.GG30719@gandalf.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32466 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbYHFKrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 06:47:51 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Tue, Aug 05, 2008 at 09:18:14PM +0530, ext Gadiyar, Anand wrote:
> If Indexed Mode register accesses are enabled, the ep0_rxstate() function calls
> musb_g_ep0_giveback() before writing to the CSR register. When control returns
> to this ep0_rxstate, the index register contents are over-written. This causes
> the CSR register write to fail.
> 
> Fixed by writing the correct value into the index register before
> writing to the CSR.
> 
> This was observed only in ep0_rxstate() with g_ether loaded and the device
> connected to a MS Windows host PC. Anticipatively fixed ep0_txstate() as well.

Hi, can you mail me (only) this patch as an attachement or put it
somewhere i can download ?

-- 
balbi
