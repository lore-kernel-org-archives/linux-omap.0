From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Fri, 20 Feb 2009 18:27:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F5656818@dbde02.ent.ti.com>
References: <20090220123137.GJ16942@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39980 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbZBTM5k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 07:57:40 -0500
In-Reply-To: <20090220123137.GJ16942@scadufax.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

> On Fri, Feb 20, 2009 at 01:40:32PM +0100, Anand Gadiyar wrote:
> > <snip>
> > 
> > > well, it's been about 5 months since you said TI would be doing such
> > > cleanups, I've even had my patches dropped at that time because of that
> > > and till now nothing happened. About the workaround, I'd rather read the
> > > errata myself and implement it.
> > 
> > Well, I've said time and again that I haven't been able to get around to it.
> > 
> > You can read the errata yourself and implement it if you wish. Frankly,
> > I don't give a damn.
> > 
> > I've spent the last five months finding the workarounds for all the
> > erratas affecting EHCI, which is __the whole reason__ why I have not
> > been able to fix up the EHCI driver.
> 
> A quick mail explaining that you wouldn't be able to fix ehci at that
> time would've been enough to avoid it. Then we could have gotten it
> cleaned up and then just integrate your latest workarounds. Still, the
> driver will need lots of cleanups before we think about adding
> workarounds and we have to think about how to integrate the workarounds
> for different ehci/omap silicon revisions, etc...

Well, the way it went was I discovered errata after errata. Everytime I thought
this is the last one and I can finally get around to that cleanup, three days
later I would end up working on the next failure.

I've spent so much time on it, I'm sick of it.


So here's the quick mail you want:
"I may or may not be able to clean up this driver in the near future. Felipe
Balbi graciously agress to do it for us. So I am pleased to announce he will
clean up this driver and send it upstream. If he needs any help with this, I
will try to provide it to him (or anyone else for that matter) on a best-effort
basis. Good luck."


> 
> Anyways, I'll keep going with my cleanups and when I get a platform to
> test ehci, I'll try to test the patches and keep going with the
> workarounds.

If you want help with testing, I can give it to you. If not, you can test
it yourself - I couldn't care less.

- Anand
