From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Sun, 23 Dec 2012 17:03:45 +0100
Message-ID: <87hancu55q.fsf@dell.be.48ers.dk>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
	<87a9t78boa.fsf@dell.be.48ers.dk>
	<20121221192234.GA10722@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:56563 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2LWQDu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 11:03:50 -0500
Received: by mail-ee0-f53.google.com with SMTP id c50so3295270eek.40
        for <linux-omap@vger.kernel.org>; Sun, 23 Dec 2012 08:03:49 -0800 (PST)
In-Reply-To: <20121221192234.GA10722@animalcreek.com> (Mark A. Greer's message
	of "Fri, 21 Dec 2012 12:22:34 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

>>>>> "Mark" == Mark A Greer <mgreer@animalcreek.com> writes:

Hi,

 >> Huh, does am335x have a sham module? I don't see any mention of that
 >> in spruh73g.pdf

 Mark> Yes.  It has sham, aes, and rng modules.

Ok, interesting.

 Mark> They are not described in the TRM.  In fact, I had to use the
 Mark> omap4 description (closely guarded by TI) because AFAIK there
 Mark> isn't a doc for the am33xx.  The am33xx modules are identical to
 Mark> the omap4 ones except for the register addresses and dma channels
 Mark> so that doc worked.

Odd. How did you figure out the am335x base address / dma channels?

-- 
Bye, Peter Korsgaard
