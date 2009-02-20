From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Fri, 20 Feb 2009 16:14:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F565677E@dbde02.ent.ti.com>
References: <6ed0b2680902200238o7b069a4fv8acb083b9771823e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35684 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758114AbZBTKou convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 05:44:50 -0500
In-Reply-To: <6ed0b2680902200238o7b069a4fv8acb083b9771823e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Friday Feb 20, 2009 Grazvydas Ignotas wrote:
> On Fri, Feb 20, 2009 at 12:46 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> > On Thu, Feb 19, 2009 at 02:43:36PM -0800, Steve Sakoman wrote:
> >> EHCI omap driver definitely needs some work - there is machine
> >> specific stuff in there that rightfully belongs in platform data.  I
> >> haven't had time to work on it :-(
> >
> > For sure, and there's still workaround for clk framework stuff that
> > should already move there.
> >
> > I'll try to start with some cleanups already during this weekend (yeah,
> > I've got no life :-p) and post as RFT asap. After the cleanups are ok,
> > then I'll start moving platform code out of there and for the clock
> > workarounds I'll need help from Paul Walmsley, probably :-)
> 
> Great, I'll be watching the list and gladly test them on pandora too.
> It would be nice to have those remote wakeup issues [1] sorted out
> too.
> 
> 1: http://marc.info/?l=linux-omap&m=122911571519657&w=2


Sorry, that is not something that will be fixed in ES3.1. It also affects
suspend-resume, not just remote-wakeup.

However, there is a software workaround that is being tested right now
- the one mentioned in the link does not work reliably. The new
workaround should be ready shortly (maybe after Felipe is done with
the cleanups he plans).

- Anand
