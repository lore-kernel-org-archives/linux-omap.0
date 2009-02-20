From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Fri, 20 Feb 2009 14:31:38 +0200
Message-ID: <20090220123137.GJ16942@scadufax.research.nokia.com>
References: <20090220115332.GG16942@scadufax.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02F5656805@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61480 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZBTMsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 07:48:25 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F5656805@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 01:40:32PM +0100, Anand Gadiyar wrote:
> <snip>
> 
> > well, it's been about 5 months since you said TI would be doing such
> > cleanups, I've even had my patches dropped at that time because of that
> > and till now nothing happened. About the workaround, I'd rather read the
> > errata myself and implement it.
> 
> Well, I've said time and again that I haven't been able to get around to it.
> 
> You can read the errata yourself and implement it if you wish. Frankly,
> I don't give a damn.
> 
> I've spent the last five months finding the workarounds for all the
> erratas affecting EHCI, which is __the whole reason__ why I have not
> been able to fix up the EHCI driver.

A quick mail explaining that you wouldn't be able to fix ehci at that
time would've been enough to avoid it. Then we could have gotten it
cleaned up and then just integrate your latest workarounds. Still, the
driver will need lots of cleanups before we think about adding
workarounds and we have to think about how to integrate the workarounds
for different ehci/omap silicon revisions, etc...

Anyways, I'll keep going with my cleanups and when I get a platform to
test ehci, I'll try to test the patches and keep going with the
workarounds.

-- 
balbi
