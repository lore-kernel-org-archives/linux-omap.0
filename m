From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 2/5] OMAP: McBSP: Modify macros/functions API for
 easy cache access
Date: Mon, 14 Dec 2009 11:36:05 -0800
Message-ID: <20091214193605.GC4575@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BC141E94@dbde02.ent.ti.com>
 <200912141111.29392.jkrzyszt@tis.icnet.pl>
 <20091214131433.5c9b26a6.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56160 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbZLNTgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 14:36:24 -0500
Content-Disposition: inline
In-Reply-To: <20091214131433.5c9b26a6.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "Varadarajan, Charu Latha" <charu@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Jarkko Nikula <jhnikula@gmail.com> [091214 03:12]:
> On Mon, 14 Dec 2009 11:11:27 +0100
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> 
> > If these functions are obsolete and going to be removed, I don't think it 
> > could be of any importance whether they are modified before removal or not. 
> > Otherwise, a solution seems simple to me: you submit a patch that addresses 
> > all concearns, yours, Tony's (BTW, have you already reviewed the drivers as 
> > Tony suggested?), maybe others. Then, after your patch is accepted for 
> > inclusion and it appears in conflict with this series still not applied for 
> > any reason (possibly waiting for your changes if that decided), Jarkko, or 
> > Tony, or anyone else pointed out by Tony, decides which one goes first and 
> > which is going to be refreshed on top of the other. Does it sound like a good 
> > plan for you?
> > 
> I would favor the Janusz's set going in first since it will solve and
> help the in-tree problems without making out-of-tree use any worse than
> currently.
> 
> - Fixes register access in polled I/O functions (out-of-tree use)
> - Fixes McBSP register corruption noted on Amstrad Delta
> - McBSP register caching could help the PM development
> 
> Fixing any other issues in polled I/O API belongs to another context
> than this patch set and IMO is easier to handle after this set since the
> patch 1/5 already fixes the register access width.

Sounds good to me.

Tony
