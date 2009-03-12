From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
 reloading dspbridge several times due to a memory leak.)
Date: Thu, 12 Mar 2009 16:19:50 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51E288@dlee02.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
 <87zlfq6497.fsf@deeprootsystems.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF51E139@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162037B7D2E7E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbZCLVUF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 17:20:05 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037B7D2E7E@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

> -----Original Message-----
> From: Woodruff, Richard
> Sent: Thursday, March 12, 2009 9:33 PM
> To: Menon, Nishanth; Kevin Hilman
> Cc: Guzman Lugo, Fernando; linux-omap@vger.kernel.org; Kanigeri, Hari;
> Lakhani, Amish; Gupta, Ramesh; Ameya Palande
> Subject: RE: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
> reloading dspbridge several times due to a memory leak.)
> > Some more isolation:
> > The l-o master branch does not have an issue, only the pm branch seems
> to have
> > the problem - probably some commit(s?) missing in pm branch. Since
> bridge is
> > based off the pm branch, wont make sense to regress on it :(.
> 
> This rings a bell from a couple months back.  I've not followed the thread
> but recall a recent fix to ioremap.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg08836.html
> 
Ouch.. commit 24f11ec001920f1cfaeeed8e8b55725d900bbb56[1] is what you are speaking of? That commit is not present in pm branch :( 

Regards,
Nishanth Menon

Ref:
1. http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=24f11ec001920f1cfaeeed8e8b55725d900bbb56 
