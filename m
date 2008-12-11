From: Paul Walmsley <paul@booyaka.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 14:07:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>
References: <1228870250.32014.148.camel@localhost.localdomain>  <1228926833.32014.162.camel@localhost.localdomain>  <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>  <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
 <20081211005733.GZ18138@atomide.com>  <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>  <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>  <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
 <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59617 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205AbYLKVH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 16:07:27 -0500
In-Reply-To: <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Thu, 11 Dec 2008, Grazvydas Ignotas wrote:

> On Thu, Dec 11, 2008 at 7:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> > Here you go.  Note that no infinite loop!
> 
> Ah, so it no longer needs that revert, probably recent clock changes
> fixed that issue.

What is baffling is that it appears to be the presence of the 
omap2_get_dpll_rate() call before the conditional that seems to be the 
primary factor in whether the loop is infinite or not.  The expression in 
the conditional will evaluate to 0 in both cases (13000000 != 120000000 
and 0 != 13000000).

Gravyzdas, can you send us a commit ID that results in successful device 
enumeration (after reverting 
http://marc.info/?l=linux-omap&m=122453174024860&w=2 ?)  Sounds like it 
was working for you in late October with that revert.


- Paul
