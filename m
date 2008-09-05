From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors on boot with 2.6.27-rc5 on omap3
Date: Fri, 5 Sep 2008 10:23:13 -0700
Message-ID: <20080905172313.GN24202@atomide.com>
References: <5e088bd90809032041u69a60e71h4c22cfa3ce06ec86@mail.gmail.com> <200809032210.31687.david-b@pacbell.net> <5e088bd90809032227v56039032v881cc4fed61b676c@mail.gmail.com> <5e088bd90809032304k3e8bbd8cncea40b90ff6ab340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60668 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbYIERXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 13:23:16 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809032304k3e8bbd8cncea40b90ff6ab340@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [080903 23:04]:
> On Wed, Sep 3, 2008 at 10:27 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> > On Wed, Sep 3, 2008 at 10:10 PM, David Brownell <david-b@pacbell.net> wrote:
> >> On Wednesday 03 September 2008, Steve Sakoman wrote:
> >>> I get similar results for both Beagle and Overo, so the error occurs
> >>> for both nand and onenand.  The boot eventually completes, of course
> >>> without nand/onenand support.
> >>
> >> Does this help?
> >>
> >>  http://marc.info/?l=linux-kernel&m=121999823616458&w=2
> >>
> >> Block layer goofage; that patch is in Jens' queue.
> 
> The above mentioned patch does fix the issue.

This is now cherry-picked to l-o tree.

Tony
