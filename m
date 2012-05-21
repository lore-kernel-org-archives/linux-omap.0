From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 12/19] ARM: OMAP4: PM: update ROM return address for
 OSWR and OFF
Date: Mon, 21 May 2012 12:29:57 +0300
Message-ID: <1337592597.28274.12.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-13-git-send-email-t-kristo@ti.com>
	 <87zk974s1o.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44154 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932384Ab2EUJaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:30:06 -0400
In-Reply-To: <87zk974s1o.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Carlos Leija <cileija@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Bryan Buckley <bryan.buckley@ti.com>

On Wed, 2012-05-16 at 16:36 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Carlos Leija <cileija@ti.com>
> >
> > At wakeup from OFF/OSWR CPU1 will call secure HAL service through a local
> > secure dispatcher with MMU off, 
> 
> Reviewers who are uninitaited in this level of detail need some more
> help here  (even those who are deeply familiar will need more help in a
> few months when they forget the details.)
> 
> So, some more detail about where this is in the code would be helpful
> here.
> 
> > thus ROM will save a PA return address.
> > Later in the wakeup, when SMC driver calls an RPC through
> > omap4_secure_dispatcher (MMU is on now), 
> 
> Again, pointer to where is this in the code would be helpful.

I believe this refers to any of the SMC calls done in the ASM files.
Most notably the one in omap-headsmp.S, which is added (rather)
illogically after this patch in the set though.

> 
> Also, it's not obvious why RPC use used here. Is that referring to the
> fact that the secure calls on CPU1 are dispatched to CPU0?  Whatever it
> means, it should be summarized in the changelog.

Not sure about this, maybe security guys can comment on this.

> 
> > ROM code won't log the new return
> > address as RPCs are handled different. Thus ROM will attempt to return to
> > a PA address when the MMU is on and the system will hang.
> >
> > We need to do this for OSWR state and OFF state of mpu power domain,
> > not just for device off(mpu pd OFF).
> 
> The code suggests that affects *all* OMAP4 revisions?  Is that correct?

I think thats right.

> 
> And once again, can this be implmented using cluster PM notifiers, where
> the notifier is registered only on affected revisions?

Should be okay to do that. I guess this should move to omap-secure.c.

> 
> (Sheesh, the number of ROM code workaounds in this series is rather
> disconcerting.)
> 
> Kevin
> 
> 


