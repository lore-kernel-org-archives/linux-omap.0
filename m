From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] alsa: add beagleboard SoC configuration.
Date: Wed, 22 Oct 2008 13:30:26 -0700
Message-ID: <5e088bd90810221330m7f40293du96897afb41f98169@mail.gmail.com>
References: <1224692929-15108-1-git-send-email-felipe.contreras@gmail.com>
	 <20081022165300.GX7341@atomide.com>
	 <200810221236.38336.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:54532 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYJVUa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 16:30:28 -0400
Received: by yx-out-2324.google.com with SMTP id 8so605270yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 13:30:27 -0700 (PDT)
In-Reply-To: <200810221236.38336.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, David Brownell <david-b@pacbell.net>

On Wed, Oct 22, 2008 at 12:36 PM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 22 October 2008, Tony Lindgren wrote:
>> This should go to alsa-devel list with l-o list cc'd. AFAIK, all
>> the omap ASoC stuff is in mainline already. I will not push it
>> to l-o until we have an ack from alsa-devel.
>
> There are multiple ASoc bits ... they're not all there yet.
> The TWL4030 codec support should be ready to go, now that its
> core has merged, plus Overo (and "soon" Beagle) board support.
>
> The twl4030-core support was the blocking issue; at least some
> of the other patches were even acked.
>
>  http://marc.info/?t=122304728600007&r=1&w=2
>
> Maybe Steve would resubmit his patches, to merge through ALSA
> into 2.6.28-rc?  I presume all the feedback from his first round
> (beginning of September) got addressed.

Yes, all of the feedback from the first round of submissions was
addressed.  I received an ack for the twl4030 codec driver as well as
the Overo driver.

At the time, the feedback from the alsa-devel list was that they were
OK with these patches living in linux-omap until the twl4030 driver
was mainline ready.

So Tony merged them into linux-omap at that point.

I am happy to resubmit the patches, if that is what folks want.  I'm
copying alsa-devel so they can weigh in on the decision.

Steve
