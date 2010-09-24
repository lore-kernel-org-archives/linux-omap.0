From: Tim Nordell <tim.nordell@logicpd.com>
Subject: Re: [RFC 2/5] OMAP: mux: Make low level function private
Date: Fri, 24 Sep 2010 18:50:26 -0500
Message-ID: <4C9D3942.8080600@logicpd.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <1285319748-28976-3-git-send-email-b-cousson@ti.com> <AANLkTikN8M+6Q0cDdp29mnQdtqSwL4Zp5Kpoz8TL+WHu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:12523 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751603Ab0IXXu3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 19:50:29 -0400
In-Reply-To: <AANLkTikN8M+6Q0cDdp29mnQdtqSwL4Zp5Kpoz8TL+WHu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

On 09/24/10 18:09, Gadiyar, Anand wrote:
> On Fri, Sep 24, 2010 at 2:45 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> omap_mux_read / omap_mux_write should not be accessed directly
>> outside the mux framework.
>> Do we really have use case that require dynamic mux change beside
>> GPIO?
>>
> 
> Only case I can think of is for any workarounds for issues that turn up.
> No such cases exist today on OMAP3 at least, and none are likely to
> appear in future (I hope). So your assumption is valid.
> 

We have a use-case here - granted the code currently is a complete hack
and not something clean enough for the mainline kernel.

We recently rediscovered the USB3320 PHY suspend issue that is in the
errata on the OMAP35x platform (Advisory 3.1.1.193) and we came up with
a workaround for it (despite the errata saying there isn't any) where
essentially we do:

1) Allow the EHCI controller to suspend the PHY as normal
2) Cut the power to the USB host controller using power domains.  This
resets the logic states in the USB host controller so that it is usable
again.
3) Remux all the pins talking to the PHY into GPIO mode
4) Monitor said pins for changes in status to know when a remote wakeup
request occurs
5) Remux pins back to USB PHY mode
6) Reenable power to the USB host controller and reinitialize registers

- Tim
