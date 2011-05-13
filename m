From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing
 preprocessor.
Date: Fri, 13 May 2011 16:45:46 +0300
Message-ID: <20110513134542.GJ5323@atomide.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
 <20110513113013.GP31483@atomide.com>
 <BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
 <4DCD2260.4090806@ti.com>
 <20110513130441.GH5323@atomide.com>
 <87aaeq3fmt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45702 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752415Ab1EMNpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 09:45:51 -0400
Content-Disposition: inline
In-Reply-To: <87aaeq3fmt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [110513 16:12]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Cousson, Benoit <b-cousson@ti.com> [110513 15:18]:
> >> >>>Signed-off-by: Vladimir Zapolskiy<vzapolskiy@gmail.com>
> >> >>
> >> >Unfortunately I don't have an automated tool, but that would be great
> >> >to have such a script. For this time I've checked the correctness of the
> >> >change comparing the preprocessed output.
> >> 
> >> In fact these files are already generated automatically, as written
> >> in the header file. So changing the output format should
> >> straightforward. At least for OMAP4... OMAP2 and OMAP3 were done
> >> manually some time ago.
> >
> > Sounds like the important thing to consider here is how these macros
> > should be set up considering the upcoming generic clock framework
> > and device tree changes.
> >
> > So let's wait a few days for comments from Benoit and Paul on the
> > format for the macros so we don't need to redo them again later.
> > Of course there might be other things to consider too..
> 
> ... like readability.
> 
> After seeing the patch (thanks Benoit), I think this is bad tradeoff
> between readability and lines-of-code.
> 
> Personally, I don't think we should be trading readability for diffstat
> goodness.  I have a strong dislike for these multi-line macros, but
> it's up to Paul/Benoit to decide how this should look.

Despite having few hard-to-read multi-line macros, this can be
used to make the actual data entries more readable. The same way as
REGULATOR_SUPPLY, OMAP3_MUX, etc.

Tony

