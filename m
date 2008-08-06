From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH RFC] MUSB: Fix index register corruption seen with g_ether and Windows host
Date: Tue, 5 Aug 2008 23:29:43 -0700
Message-ID: <200808052329.43723.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:43660 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753545AbYHFG3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 02:29:46 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Tuesday 05 August 2008, Gadiyar, Anand wrote:
> If Indexed Mode register accesses are enabled, the ep0_rxstate() function calls
> musb_g_ep0_giveback() before writing to the CSR register. When control returns
> to this ep0_rxstate, the index register contents are over-written. This causes
> the CSR register write to fail.
> 
> Fixed by writing the correct value into the index register before
> writing to the CSR.
>	...
> Dave, you wrote the original commit (5dd8c56c) on linux-omap that moved the
> register write after the call to the giveback function [1]. Could you take
> a look at this patch please?

This looks fair.  All it does is make sure that the index
register points where it's expected to point; what could
that break?


