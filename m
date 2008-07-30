From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: USB driver issue
Date: Wed, 30 Jul 2008 22:55:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91ED@dbde02.ent.ti.com>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E7@dbde02.ent.ti.com>,<20080730164428.GS25065@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:37308 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbYG3RZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jul 2008 13:25:17 -0400
In-Reply-To: <20080730164428.GS25065@intune.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel.stone@nokia.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Emanoil Kotsev <deloptes@yahoo.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, SUBHRANIL CHOUDHURY <subhra85@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

> On Wed, Jul 30, 2008 at 09:53:43PM +0530, ext Gadiyar, Anand wrote:
> > Grr. Saying one needs to upgrade to the latest kernel before one can expect
> > support is a bit like certain proprietary OS vendors - and even they do a better
> > job than this.
>
> If you want to support people running 2.6.22, good for you.  You seem to
> be happy with a codebase that doesn't change as much, so I'm sure you'll
> have fun supporting it.

Second sentence isn't true. The third probably is. I do enjoy finding why something
doesn't work. Maybe you should give it a shot sometime.


> I'm getting the feeling that we need a new Godwin's law: as a thread
> involving a complaint about open source grows longer, the probability of
> a comparison involving Microsoft approaches one.

Okay. That comparison wasn't warranted, I guess. But here's what went through
my mind when I read Felipe's post. "If you want this to work, then upgrade". And
that looked exactly like MS telling me "I can't help you with XP anymore, move on
to Vista mate".

Why on earth do we have the stable trees then? Why do people put in their time
porting fixes back to the 2.6.22.* 'stable' trees? There are still people out there
that use them, for whatever reason. And they do run into bugs that still haven't been
caught.


> So yes, some people don't want to support old code on their own time.
> So what? Who are you to tell them that they can't do this? What was the

I don't particularly care if people don't want to support old code. What I do
care about is the attitude that's out here - "Hey! Move up in life man! Get the
latest, greatest, RC kernel! 2.6.24 is ancient, 2.6.26 is ancient!". Yes, I do use
2.6.27-rc1 prepatch. But I do recognize that there are people out there who don't.

Yes people should ideally work off the latest. But that shouldn't mean one won't
get help if one is not using the latest. Or am I totally wrong here?


> point of the Microsoft comparison, except to reinforce stereotypes that
> free software developers are a bunch of freaks with unhealthy obsessions
> on Microsoft and LOL BILL GATES IS THE SUCK?

The Microsoft comparison was totally out of place. Please accept my apologies
for bringing it up.

>
> (Bearing in mind that one of the main tenets of open source development
 > is 'release early and release often', you could say that having
 > everyone use very old code until you one day drop a huge chunk of
 > rewritten new code on them is also OMG MICROSOFT.  But that'd be
>  equally stupid.)
