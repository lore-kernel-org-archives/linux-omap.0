From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP support in mainline?
Date: Fri, 19 Sep 2008 08:50:05 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203657CA5E8@dlee02.ent.ti.com>
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
	 <13B9B4C6EF24D648824FF11BE896716203657701DB@dlee02.ent.ti.com>
 <1221814185.31752.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35860 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbYISNuS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 09:50:18 -0400
In-Reply-To: <1221814185.31752.11.camel@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi Igor,

> -----Original Message-----
> > Where do you think the lineage of the hardware and software is?  Do
> you believe it just jumped into being in open source?  All hardware and
> software is full of deliberate design and hacks. Its true cooperate
> design constraints are driven by the bottom line and for some in open
> source it is not.
>
> Getting the HW to work somewhere is not good enough. It must be
> supported in mainline, the more code you generate out of mainline, the
> less likely anybody can get it to work after a while and it slows down
> everybody.

Sure. In this case I'm just airing some frustration. It is not like some version of this isn't already shipping years back in N800. Rapid development/advancement is great but there should be a working spot which isn't by just by chance.

In this case a tree is just like a branch.  We have done some new development outside on this branch to enable a new dma mode to boost performance.  Hopefully that will be folded back in before too much time. I think I've seen a patch even. In the past we would have just 2x the performance on some old kernel and made it available.  But probably so out of phase you really had to work to get it.  Today using a current tree it is there and there is a lot better chance we or some community person will push it back.

Maybe a custodian for pieces would help.  This is like what Wolfgang Denk did on u-boot...

> > Maybe those who are interested in it should work on a branch in the
> tree and periodically merge back at stable points.  Maybe finally merged
> drivers at kernel.org will server that purpose and the local tree's can
> be all development.
> >
> > Where we need something working for a customer 'today' we export a
> tree to do this. ...many strong statements in open source might be
> grouped as religious, lobbyist, or novice. We all use some mix of these
> in work.  What's your mix on this issue?
>
> I'm no open source zealot, I'm being just very selfish and I think my
> life would be much simpler if there were less trees.

Probably not more simple, but perhaps more efficient in translating things to mainline. But this does require more compromises then most are able to do. How do you 'rush' some critical piece in?  Rush is very much a relative thing.

This is an area where perhaps branching and tags along with use of kconfig-experimental can help.  This hasn't been explored in the tree.  Tony _DID_ offer to do a branch back in OMAP2. However, we weren't structured to support it then. Even if we were so structured, there was a bit difference in timeline need. We would have done a functional (proven w/test) version 1.0, where others with different constraints would have been shooting for a v3.0. Why not start at a 3.0 you say it in theory its great, you can even skip a 2.0. Who can argue with that?

The answer here lies in the fact that a v3.0 design might catch you an A even if it doesn't work for 2 years in a University but you will get an F in industry if you are on a 1 year cycle.  Most people in business here are aggressive and selfish. And they are not selling the code they are selling the device.

All customers & users are different.  If you are starting a new business you might have 3 years before you need to make money, others want to protect what they have and keep shipping with out change, and yet others are desperate and need something yesterday or they will die.  The way each act and their tradeoffs are at very different thresholds.

To me, it seems you should look at your users and their capabilities and their cycles and try to best harness them to create the best tree possible.  This does lead to some unevenness but it tries to catch all the energy which is out there. If you look at it this way you might be able to plan a 1.0, 2.0, 3.0 on a per piece basis and then let it happen in a distributed way.  Perhaps this is the way upper Linux operates.  Linus can't tailor every bit and has written it is not possible and will drive those who try crazy.

Zealots will say they don't want any of that evil energy, realists and engineers will try to optimize, and marketers will try to take advantage.

This all is too much talk and takes away from more interesting playing with devices. Having different tree's about is kind of natural.  They only way you get away with one are with flexibility and commitment.

> Notice that Kevin Hilman has just created a pm branch from linux-omap,
> but that is named actually pm-0 and it means that it will be rebased and
> it is expected to disappear and dissolve into the main.
>
> That doesn't really apply to your omapzoom tree.
>
> Notice also that most of the patches not ready for being merged in pm-0,
> which justify its existence, are coming from omapzoom.

Yes.  This is great and productive.  Many people have contributed to the patches which his is organizing. The idea for it came from TI/Nokia/Tony/Kevin/Paul dialog. Kevin before as part of MV also contributed to the zoom tree in some form and in many many other places.

Regards,
Richard W.

