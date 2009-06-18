From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and kick
Date: Thu, 18 Jun 2009 08:03:15 -0700
Message-ID: <87ab45twi4.fsf@deeprootsystems.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
	<1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com>
	<13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:52319 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbZFRPDf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 11:03:35 -0400
Received: by pzk5 with SMTP id 5so403048pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 08:03:37 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com> (Richard Woodruff's message of "Wed\, 17 Jun 2009 19\:04\:58 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mike Chan <mikechan@google.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

> Hi Paul,
>
> Hm, seems my mailing is out to lunch today...  I'll be worse than normal in protocol and top post.
>
> I've seen this issue on a couple custom boards.  In these instances
> I've not had access to boot loaders.  I would expect this issue
> would show up in the wild in some devices.  It might be ok to move
> to at least init.  Having it at deadlock spot is a bit more
> conservative.

Richard, since Paul and I cannot reproduce this currently, would you be able to test
if a fix at init fixes the problems that you've seen?

Kevin

> I've only seen the condition along side of very aggressive SDRC_POWER settings. Its my guess beagle doesn't enable all those features yet.  Unless you have a bunch of beagle accessories attached, I'm not sure how good a reference beagle is for system DVFS validation.
>
> I've not taken stat's to see how much it happens. The alternate to the latency spike is a dead lock which is clealry not wanted.  Net-Net I see this as more a plus than a minus in current form.
>
> If you have some time you might expirment with beagle and see if you can trigger the condition.
>
> Regards,
> Richard W.
>
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, June 17, 2009 3:04 AM
>
> So, what is different about your setup?  The usual suite of questions:
>
> - What chip revisions/boards does this affect?
>
> - Is this specific to certain bootloaders?
>
> - Has anyone else out there seen this problem?
>
> Rather than working around an occasional DLL failure to lock, is it possible to reset the DLL earlier in the boot process, as Richard's commit message suggests?  That would be preferable to this approach.  A back-of-the-envelope assessment suggests that this patch could cause unpredictable, additional 1.5 millisecond latency spikes whenever the workaround triggers (since OCM RAM is marked uncacheable).
