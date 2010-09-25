From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [RFC 2/5] OMAP: mux: Make low level function private
Date: Sat, 25 Sep 2010 05:37:17 +0530
Message-ID: <62d32f04402a5bf019e754bd15a70069@mail.gmail.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <1285319748-28976-3-git-send-email-b-cousson@ti.com> <AANLkTikN8M+6Q0cDdp29mnQdtqSwL4Zp5Kpoz8TL+WHu@mail.gmail.com>
 <4C9D3942.8080600@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57596 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754805Ab0IYAHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 20:07:20 -0400
Received: by mail-wy0-f182.google.com with SMTP id 33so4794384wyb.27
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 17:07:19 -0700 (PDT)
In-Reply-To: <4C9D3942.8080600@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Nordell <tim.nordell@logicpd.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Tim Nordell [mailto:tim.nordell@logicpd.com]
> Sent: Saturday, September 25, 2010 5:20 AM
> To: Gadiyar, Anand
> Cc: Benoit Cousson; linux-omap@vger.kernel.org; Tony
> Lindgren; Paul Walmsley; Kevin Hilman
> Subject: Re: [RFC 2/5] OMAP: mux: Make low level function private
>
> On 09/24/10 18:09, Gadiyar, Anand wrote:
> > On Fri, Sep 24, 2010 at 2:45 PM, Benoit Cousson
> <b-cousson@ti.com> wrote:
> >> omap_mux_read / omap_mux_write should not be accessed directly
> >> outside the mux framework.
> >> Do we really have use case that require dynamic mux change beside
> >> GPIO?
> >>
> >
> > Only case I can think of is for any workarounds for issues
> that turn up.
> > No such cases exist today on OMAP3 at least, and none are likely to
> > appear in future (I hope). So your assumption is valid.
> >
>
> We have a use-case here - granted the code currently is a complete hack
> and not something clean enough for the mainline kernel.
>
> We recently rediscovered the USB3320 PHY suspend issue that is in the
> errata on the OMAP35x platform (Advisory 3.1.1.193) and we came up with
> a workaround for it (despite the errata saying there isn't any) where
> essentially we do:
>
> 1) Allow the EHCI controller to suspend the PHY as normal
> 2) Cut the power to the USB host controller using power domains.  This
> resets the logic states in the USB host controller so that it is usable
> again.
> 3) Remux all the pins talking to the PHY into GPIO mode
> 4) Monitor said pins for changes in status to know when a remote wakeup
> request occurs
> 5) Remux pins back to USB PHY mode
> 6) Reenable power to the USB host controller and reinitialize registers

We've tried this technique before - you still need to re-enumerate after
the resume, right? So you might as well just power down the PHY and
you should be able to recover.

Ajay Gupta did a lot of work on this - not sure if this worked well. We
basically gave up on this interoperability issue and decided to work
around it in newer silicon. 3630 ES1.1 and later has suspend-resume
working with the SMSC PHY.

- Anand
