From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Fri, 13 Aug 2010 13:29:34 +0300
Message-ID: <20100813102933.GN12706@atomide.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
 <20100813080200.18750.37791.stgit@baageli.muru.com>
 <4C651635.8000201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55389 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761408Ab0HMK3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 06:29:42 -0400
Content-Disposition: inline
In-Reply-To: <4C651635.8000201@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

* Sergei Shtylyov <sshtylyov@mvista.com> [100813 12:48]:
> Hello.
> 
> Tony Lindgren wrote:
> 
> >From: Kevin Hilman <khilman@ti.com>
> 
> >Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> >mistakenly removed the check for PER when disabling the IO chain.
> >
> >During idle, if the PER powerdomain transitions and CORE does not (as
> 
>   Does not what?

How about ".. and CORE does not transition"?

Kevin, care to clarify that?

Tony
