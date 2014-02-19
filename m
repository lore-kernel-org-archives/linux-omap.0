From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP
 Support (fwd)
Date: Wed, 19 Feb 2014 19:22:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402191920040.8777@utopia.booyaka.com>
References: <alpine.DEB.2.02.1402191824260.8777@utopia.booyaka.com> <CANacCWy10TTJenrZ6hdTN8bCpAQQjRa5MOBPde7bnn-LM+VFbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43074 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbaBSTWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 14:22:46 -0500
In-Reply-To: <CANacCWy10TTJenrZ6hdTN8bCpAQQjRa5MOBPde7bnn-LM+VFbw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>

On Wed, 19 Feb 2014, Vaibhav Bedia wrote:

> On Wed, Feb 19, 2014 at 1:25 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Just FYI.  Queued for v3.15 unless someone complains.
> >
> 
> No complains but i wanted to point out that with some additional
> changes it's possible
> to consolidate AM335x (and AM437x) very nicely with the rest of OMAP4+
> PRM/CM code.
> 
> I had posted a series (which had a similar patch) a while back [1] but
> that got never
> got any feedback :/

Yeah, to be honest I don't like the consolidation approach.  The reason 
why is because the hardware seems to be quite different underneath, so the 
risk of breaking another chip is high.

> If one looks hard enough AM335x/AM437x/TI81xx are not that different 
> from OMAP4+ :)

Hmm, it's my understanding that the hardware implementations are quite 
different between the Wireless and the Catalog parts.  Certainly the 
Wireless engineers didn't have any knowledge at all of what Catalog folks 
were doing, and many implementation assumptions that held true across 
several Wireless parts did not hold up at all when extended to Catalog 
parts.



- Paul
