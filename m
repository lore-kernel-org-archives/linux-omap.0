From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Tue, 29 Jul 2008 22:18:00 +0300
Message-ID: <20080729191759.GE7275@frodo>
References: <488F48E3.2060504@indt.org.br> <20080729183717.GB7275@frodo> <fb249edb0807291157v40f4c0e0vf0e35b1beb39cd3b@mail.gmail.com> <13B9B4C6EF24D648824FF11BE89671620361D432D8@dlee02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47476 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYG2TST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 15:18:19 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361D432D8@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: andrzej zaborowski <balrogg@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jul 29, 2008 at 02:07:51PM -0500, Woodruff, Richard wrote:
> > How about renaming it to twl92230c before submitting upstream?  As far
> > as I can tell the name menelaus appears only in linux and makes it
> > hard to associate with the real hardware.  Does someone know why was
> > it renamed that way?

> A number does seem more understandable.  Though some of these chips live under a few different numbers.

it does seem more understandable, but now that it has been used for so
long I guess it would be nasty to change right now. Almost every one
here knows that menelaus is the companion chip for omap2 hw. Personally,
I never recall the correct number designation for menelaus.

I mean, I don't really have any problems in renaming the whole driver
from menelaus to twl92230c.c but I can't help asking myself why. If
everybody thinks it's a better choice, then why not ;-)

-- 
balbi
