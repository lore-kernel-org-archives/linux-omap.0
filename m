From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Thu, 6 Nov 2008 21:54:08 -0800
Message-ID: <200811062154.08843.david-b@pacbell.net>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <20081106170445.GU21736@atomide.com> <6ed0b2680811061219p40439337h2a6938009aa20522@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:26704 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750911AbYKGFyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 00:54:12 -0500
In-Reply-To: <6ed0b2680811061219p40439337h2a6938009aa20522@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thursday 06 November 2008, Grazvydas Ignotas wrote:
> I have another SD slot connected to MMC2 via transceiver (in addition
> to usual MMC1). I wonder how can I add support for that? The easiest
> way is to add remaining twl_mmc2_* functions mmc-twl4030.c,

I plan a followon to the patch I just sent, which will let the GPIOs
hook up more generically and remove the need for most such non-generic
functions.


> and it 
> works, but this stuff would be useless for all other boards, and I
> know you hate #ifdefs here.

It would help if you explained what needed #ifdeffing, so we
don't need to guess.  I didn't see schematics in any easily
found location on openpandora.org (that's your board?).

Do VMMC1 and GPIO-0/CD hook up to MMC1?
Do VMMC2 and GPIO-1/CD hook up to MMC2?


> Another way is to just copy mmc-twl4030.c 
> and add stuff there, but that would result in lots of code
> duplication. BTW, we also have wifi chip on MMC3.
> Any ideas?

For MMC3 you'll need to write some stuff to hook to that
controller ... currently only MMC1 and MMC2 are set up.

- Dave

