From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: OMAP support in mainline?
Date: Fri, 19 Sep 2008 11:49:45 +0300
Message-ID: <1221814185.31752.11.camel@localhost>
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
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54413 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbYISMVP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 08:21:15 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203657701DB@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

On Thu, 2008-09-18 at 08:36 -0500, ext Woodruff, Richard wrote:

> Where do you think the lineage of the hardware and software is?  Do you believe it just jumped into being in open source?  All hardware and software is full of deliberate design and hacks. Its true cooperate design constraints are driven by the bottom line and for some in open source it is not.

Getting the HW to work somewhere is not good enough. It must be
supported in mainline, the more code you generate out of mainline, the
less likely anybody can get it to work after a while and it slows down
everybody.

<snip>

> It would be nice if whatever code was on the main branch was not so frequently broken. 

That's why having more people working on the same code and doing review
would help.

> Maybe those who are interested in it should work on a branch in the tree and periodically merge back at stable points.  Maybe finally merged drivers at kernel.org will server that purpose and the local tree's can be all development.
> 
> Where we need something working for a customer 'today' we export a tree to do this. ...many strong statements in open source might be grouped as religious, lobbyist, or novice. We all use some mix of these in work.  What's your mix on this issue?

I'm no open source zealot, I'm being just very selfish and I think my
life would be much simpler if there were less trees.

Notice that Kevin Hilman has just created a pm branch from linux-omap,
but that is named actually pm-0 and it means that it will be rebased and
it is expected to disappear and dissolve into the main.

That doesn't really apply to your omapzoom tree.

Notice also that most of the patches not ready for being merged in pm-0,
which justify its existence, are coming from omapzoom.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
