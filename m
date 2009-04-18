From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: 2.6.29 and SDP3430
Date: Fri, 17 Apr 2009 20:45:30 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037BE5AC90@dlee02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
 <20090409100343.71d34c16.jarkko.nikula@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162037BCF1CFB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbZDRBpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 21:45:41 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037BCF1CFB@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

>
> > > I wonder if the timer stopped ticking.  If you connect with emulator take
> > > a look at GPT1 registers and see if time base is moving.
> > >
> > > Another quick test is to shut off tickles, nohz=off.
> > nohz=off did not work with either 2007q3 or 2008q3.. have'nt looked at the
> GPT
> > regs though..
>
> Hmm, something is broke.

One clue.

I see that the TLDR/TCRR are not being written too before the calibration loop starts.  The write watch point is never hit.  So no interrupts have ever fired.

The TIER is enabled but no one gets around to writing to actually set an interrupt wake.  If you setup the timer to generate an interrupt it will take off and run till some USB clock related failure.

For some reason system_timer init is not being fully done before jiffy loop.

Regards,
Richard W.
