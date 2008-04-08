From: Tony Lindgren <tony@atomide.com>
Subject: Re: source.mvista links are broken
Date: Tue, 8 Apr 2008 20:08:40 +0000
Message-ID: <20080408200839.GA31071@atomide.com>
References: <87myo9a3kf.fsf@paris.hilman.org> <010C7BAE6783F34D9AC336EE5A01A08805C303DA@dbde01.ent.ti.com> <010C7BAE6783F34D9AC336EE5A01A08805C30581@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65059 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243AbYDHUIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 16:08:49 -0400
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805C30581@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [080408 08:30]:
> <snip> 
> 
> > 
> > I'm still unable to clone the git tree from the mvista site.
> > 
> > I use "git clone http://source.mvista.com/gittrees/linux-omap-2.6.git"
> > 
> > I can't use the git://* URLs either. I'm behind a proxy and exporting
> > http_proxy isn't helping.
> > 
> 
> Was finally able to clone from kernel.org. Found the correct http URL from 
> http://www.muru.com/linux/omap/README_OMAP_GIT.
> 
> 
> > At least, I'm able to browse the tree from the mvista server and get
> > file changelogs, etc from there.
> 

Sorry for the delay on this, I did not get a chance to look into this
during the weekend, and then was travelling back home on Monday.

Well I ran git-fsck --full on source.mvista.com, and it produced missing
links errors.

So I just cloned the repo from kernel.org and added back the branches.
It should work now, let me know if any issues.

I have no idea what might have corrupted the repo, maybe disk errors?

Regards,

Tony
