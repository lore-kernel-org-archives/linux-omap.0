From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
Date: Tue, 15 Mar 2011 06:57:51 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B067CBA@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1299759058-26342-3-git-send-email-kalle.jokiniemi@nokia.com>
 <alpine.DEB.2.00.1103100752370.15132@utopia.booyaka.com>
 <9D0D31AA57AAF5499AFDC63D6472631B067824@008-AM1MPN1-036.mgdnok.nokia.com>
 <alpine.DEB.2.00.1103141322460.4431@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:62464 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169Ab1COG6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 02:58:07 -0400
In-Reply-To: <alpine.DEB.2.00.1103141322460.4431@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com, b-cousson@ti.com

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of ext Paul Walmsley
> Sent: 14. maaliskuuta 2011 21:27
> To: Jokiniemi Kalle (Nokia-MS/Tampere)
> Cc: linux-watchdog@vger.kernel.org; wim@iguana.be; khilman@ti.com;
> linux-omap@vger.kernel.org; tony@atomide.com; jhnikula@gmail.com;
> Koskinen Ilkka (Nokia-MS/Tampere); b-cousson@ti.com
> Subject: RE: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
> 
> Hello Kalle,
> 
> On Mon, 14 Mar 2011, kalle.jokiniemi@nokia.com wrote:
> 
> > What about the 1/2 patch? Is that going in, and to which kernel
> > version (our integrator would like to put in a note when we can remove
> > the back ported patch)
> 
> It's queued for Linus for the upcoming merge window:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> 2.6.git;a=commit;h=0503add9d251db22ba2f610fb8d9b7743a9786da
> 
> Thread here:
> 
> http://www.spinics.net/lists/linux-omap/msg48381.html
> 
> If there aren't further comments on the watchdog patch, and Linus is okay
> with the branch, it should appear in 2.6.39.

Thanks for the confirmation.

- Kalle


> 
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
