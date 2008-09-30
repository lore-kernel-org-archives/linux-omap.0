From: David Brownell <david-b@pacbell.net>
Subject: Re: does twl3040-pwrirq.c "need" to be a separate file?
Date: Tue, 30 Sep 2008 11:03:03 -0700
Message-ID: <200809301103.03633.david-b@pacbell.net>
References: <200809291417.12437.david-b@pacbell.net> <20080930092225.GD4552@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:33869 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751446AbYI3SDG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 14:03:06 -0400
In-Reply-To: <20080930092225.GD4552@codecarver.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Peter,

On Tuesday 30 September 2008, Peter 'p2' De Schrijver wrote:

> > I see your patch 68d7477caca19c0b52b5d4e85700cd3e6115577f created
> > pwrirq.c as a separate file and thread.
> 
> I guess choose this solution because it was similar to the GPIO IRQs.
> Originally, this was 1 shared IRQ. But I wanted to change this to avoid
> every driver having to read PWR_ISR1 and clear his interrupt. This saves
> some i2c transactions.

Right; modularization is appropriate.  Although it doesn't
seem to have hit all the TWL "subchips" yet ... :)


> > I'm wondering if there's any particular reason that "bank" of
> > interrupts shouldn't be handled directly by twl4030-core, and
> > even by the same IRQ handling thread.
> > 
> 
> I don't think so.
> 
> > As it stands now the TWL "core" is not especially core-ish in
> > this respect, and I'd like to see that be resolved (e.g. by a
> > patch I'll probably write this afternoon) before this code
> > goes to mainline ...
> 
> Ok. Good.

Thanks for the sanity check.

- Dave
