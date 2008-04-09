From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: source.mvista links are broken
Date: Wed, 9 Apr 2008 12:38:32 +0530
Message-ID: <5d5443650804090008l553e4773i259126743df6b49e@mail.gmail.com>
References: <87myo9a3kf.fsf@paris.hilman.org>
	 <010C7BAE6783F34D9AC336EE5A01A08805C303DA@dbde01.ent.ti.com>
	 <010C7BAE6783F34D9AC336EE5A01A08805C30581@dbde01.ent.ti.com>
	 <20080408200839.GA31071@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:23401 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbYDIHIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 03:08:34 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3312308mue.5
        for <linux-omap@vger.kernel.org>; Wed, 09 Apr 2008 00:08:32 -0700 (PDT)
In-Reply-To: <20080408200839.GA31071@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

Hi Tony,

On Wed, Apr 9, 2008 at 1:38 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Gadiyar, Anand <gadiyar@ti.com> [080408 08:30]:
>
> > <snip>
>  >
>  > >
>  > > I'm still unable to clone the git tree from the mvista site.
>  > >
>  > > I use "git clone http://source.mvista.com/gittrees/linux-omap-2.6.git"
>  > >
>  > > I can't use the git://* URLs either. I'm behind a proxy and exporting
>  > > http_proxy isn't helping.
>  > >
>  >
>  > Was finally able to clone from kernel.org. Found the correct http URL from
>  > http://www.muru.com/linux/omap/README_OMAP_GIT.
>  >
>  >
>  > > At least, I'm able to browse the tree from the mvista server and get
>  > > file changelogs, etc from there.
>  >
>
>  Sorry for the delay on this, I did not get a chance to look into this
>  during the weekend, and then was travelling back home on Monday.
>
>  Well I ran git-fsck --full on source.mvista.com, and it produced missing
>  links errors.
>
>  So I just cloned the repo from kernel.org and added back the branches.
>  It should work now, let me know if any issues.
>
>  I have no idea what might have corrupted the repo, maybe disk errors?
>

I am not able to find x-loader git tree, maintained by Kyungmin Park
of Samsung on source.mvista.com?

-- 
---Trilok Soni
http://triloksoni.wordpress.com
