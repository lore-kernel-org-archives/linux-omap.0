From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmtimer posting
Date: Wed, 2 Apr 2008 10:23:40 +0300
Message-ID: <20080402072340.GH31913@atomide.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com> <20080319155835.GE14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA8F8@dlee13.ent.ti.com> <20080320115749.GF14978@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903D3B096@dlee13.ent.ti.com> <20080331104904.GK26502@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903E22347@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65488 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbYDBHXt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 03:23:49 -0400
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903E22347@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [080331 15:18]:
> > > > Attached is a rev-4 with the cpu_relax() added to while loops as
> > > > suggested by Ladislav, and CTRL register defines moved to the
> right
> > > > location.
> > >
> > > I confirm this version of the patch works on 3430 with latest
> kernel.
> > 
> > I'll push the rev-4 version of the patch today. The second patch needs
> > a bit more work still.
> 
> Great.  
> 
> I've been testing on a few systems with a functional variant of the 1st
> + 2nd patch back ported to older TI CDP kernels.  So far I've only ran
> into positive side effects.  No noticeable load, pass normal functional
> tests, and still able to hit all low power states.
> 
> In that variant I just added a load_start() function in addition to the
> load function and converted all the in tree callers to use this as they
> all called load() then start() in order anyway.  This left the API
> behavior the same but optimized all current users.

Can you send a patch against l-o tree for the load_start()? That might
be optimized enough :)

Tony


> Regards,
> Richard W.
> 
> I did get my ETM adaptor board back so I have been able to verify
> directly.  ETM is cool in that you can get (depending on filtering)
> almost a 60 second complete capture of instruction execution during some
> use case.
