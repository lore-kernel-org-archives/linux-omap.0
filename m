From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Sat, 25 Jun 2011 16:47:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com> <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38520 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1FYWrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 18:47:01 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sun, 26 Jun 2011, Premi, Sanjeev wrote:

> [sp] I didn't include a reason - because the problem may not
>      be reproducible on the public trees.
> 
>      During tests performed in internal development trees, the
>      BogoMIPS calculations @ 1GHz wouldn't go beyond "830-850"
>      range. While there was no such inconsistency on OMAP3EVM.

There are some other reasons to avoid GPTIMER12 when possible, which you 
should probably put in the patch description.  The most important, in my 
view, is that the clock source for GPTIMER12 is much less frequency-stable 
than the clock sources for GPTIMER1.  So using GPTIMER12 can result in 
major time skew over a fairly short interval.

I've been meaning to send a patch like this for some time, so I'm happy to 
see this fixed.


- Paul
