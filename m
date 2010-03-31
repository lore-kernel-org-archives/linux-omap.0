From: Ralph Corderoy <ralph@inputplus.co.uk>
Subject: Re: [RFC][PATCH v2 1/5] omap1: Amstrad Delta: add FIQ
	handler for serial keyboard port interrupt processing
Date: Wed, 31 Mar 2010 01:06:57 +0100
Message-ID: <20100331000657.D97895225@blake.inputplus.co.uk>
References: <201003291619.25878.jkrzyszt@tis.icnet.pl>
	<201003291624.10034.jkrzyszt@tis.icnet.pl>
	<20100329183211.F105C493B@blake.inputplus.co.uk>
	<201003301708.41634.jkrzyszt@tis.icnet.pl>
Reply-To: Discussion of the Amstrad E3 emailer hardware/software
	<e3-hacking@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e3-hacking-bounces@earth.li>
In-reply-to: <201003301708.41634.jkrzyszt@tis.icnet.pl> 
List-Unsubscribe: <http://www.earth.li/cgi-bin/mailman/options/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=unsubscribe>
List-Archive: <http://www.earth.li/pipermail/e3-hacking>
List-Post: <mailto:e3-hacking@earth.li>
List-Help: <mailto:e3-hacking-request@earth.li?subject=help>
List-Subscribe: <http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=subscribe>
Sender: e3-hacking-bounces@earth.li
Errors-To: e3-hacking-bounces@earth.li
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Hi Janusz,

> And thanks for pushing me into reading the ARM Assembly Language book,
> so I would be able to do more than just understanding and copy-pasting
> the code ;).

It's a lovely instruction set compared to many others.

> > > +state:
> > > +	ldr r10, [r9,#FIQ_STATE]
> > > +	cmp r10, #0				@ are we expecting start bit?
> > > +	bne data				@ no - in data processing state
> >
> > Similarly, an `ldrs' here would make the cmp redundant.
> 
> I'm not sure if the S suffix is also valid for memory transfer
> instructions

No, you're correct.  Memory transfers can't do the "set ALU flags"
S-bit.  Sorry to mislead.

Cheers,
Ralph.
