From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP support in mainline?
Date: Thu, 18 Sep 2008 08:36:06 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203657701DB@dlee02.ent.ti.com>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com>
	 <20080917082043.04c94e2d.jarkko.nikula@nokia.com>
	 <200809162255.00918.david-b@pacbell.net>
	 <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl>
	 <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com>
	 <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl>
	 <20080918095537.GD28615@gandalf.research.nokia.com>
	 <DC3E0288-2605-450F-9E54-9B170B7669C9@student.utwente.nl>
	 <FCCFB4CDC6E5564B9182F639FC356087022A3162A3@dbde02.ent.ti.com>
 <1221738810.3873.37.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57671 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbYIRNgT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 09:36:19 -0400
In-Reply-To: <1221738810.3873.37.camel@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

> > > And, no, I'm not going to try omapzoom stuff, I want it working on
> the
> > > canonical linux-omap kernel, not some corporate version with god
> knows
> > > how many hacks.
> >
> > Your wish.
> > I thought debugging and fixing the issue was more important than the
> source of the fix !!!
>
> YES!
> You have precisely exposed the problem with TI.
> It could not have been formulated in a better way.

Where do you think the lineage of the hardware and software is?  Do you believe it just jumped into being in open source?  All hardware and software is full of deliberate design and hacks. Its true cooperate design constraints are driven by the bottom line and for some in open source it is not.

If I look at this particular MUSB hardware/software stack I know it's a mix of purest work, semi-pure (sponsored by cooperate), and cooperate.  A lot of parties have advanced the technology with different agendas.  I've followed it from its start of life in hardware to its current state.

One positive bit for this block is most of the parties today are publicly making their work and specifications available. Hopefully with this enablement code will be free to evolve.

It would be nice if whatever code was on the main branch was not so frequently broken. Maybe those who are interested in it should work on a branch in the tree and periodically merge back at stable points.  Maybe finally merged drivers at kernel.org will server that purpose and the local tree's can be all development.

Where we need something working for a customer 'today' we export a tree to do this. ...many strong statements in open source might be grouped as religious, lobbyist, or novice. We all use some mix of these in work.  What's your mix on this issue?

Regards,
Richard W.

