From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and kick
Date: Thu, 18 Jun 2009 14:21:34 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E2ACC0E@dlee02.ent.ti.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
	<1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com>
	<13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
 <87ab45twi4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37951 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbZFRTVo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 15:21:44 -0400
In-Reply-To: <87ab45twi4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mike Chan <mikechan@google.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, June 18, 2009 10:03 AM

> > I've seen this issue on a couple custom boards.  In these instances
> > I've not had access to boot loaders.  I would expect this issue
> > would show up in the wild in some devices.  It might be ok to move
> > to at least init.  Having it at deadlock spot is a bit more
> > conservative.
>
> Richard, since Paul and I cannot reproduce this currently, would you be able
> to test
> if a fix at init fixes the problems that you've seen?

I did up the fix at this spot for a couple reasons.
        -1- This is where it was locked up...
        -2- This kind of operation needs to happen in uncached sram

Doesn't doing at 1st init require pushing of another sram?  Also as its not conclusive what causes it to enter this state other than SDRC_POWER association its safer to do it here.

I think the boot loader should have tried to do this correctly.  But I really don't know what it did.

Regards,
Richard W.


