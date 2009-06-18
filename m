From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] SDRC: Remove SDRC_POWER register configuration from
 SDRC 	init.
Date: Thu, 18 Jun 2009 14:07:44 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E2ACBED@dlee02.ent.ti.com>
References: <1245245721-7052-1-git-send-email-Artem.Bityutskiy@nokia.com>
	 <alpine.DEB.2.00.0906171021120.3382@utopia.booyaka.com>
	 <62697B07E9803846BC582181BD6FB6B80D704A359D@NOK-EUMSG-02.mgdnok.nokia.com>
 <8bb80c380906181200i58d949c2y4b8cc0cf4d95e448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46722 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756666AbZFRTHx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 15:07:53 -0400
In-Reply-To: <8bb80c380906181200i58d949c2y4b8cc0cf4d95e448@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>
Cc: "Derrick, David" <dderrick@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> From: Mike Chan [mailto:mike@android.com]
> Sent: Thursday, June 18, 2009 2:01 PM

> > >> Bootloader must configure proper settings for SDRC before starting
> > >> kernel from SDRAM. Furthermore, removed lines violated omap3430 and
> > >> omap2420 SDRC errata (see errata 1.150)
> > >
>
> This seems like it will make the kernel even more dependent on the
> bootloader. As an example, there's code such as the IVA2 reset which
> attempts to put the hardware in a good state even if the bootloader
> screws up. Unfortunately not everyone has access to their bootloader
> code.

Yes, I agree with Mike here.  Not every one can touch the bootloader.  And many operations the boot loader doesn't have context to know what the best setting for an application will be.

The boot loader needs to setup a valid DDR config for sure.  However, its unlikely it will setup for 'optimal' power management.  Further, when there are run time bugs fixes really only the kernel can do this.

You will need to turn on and off autocount before OFF mode on ES3.1.  Not doing so can result in trouble as the mask ROM itself before restoring context to kernel makes a mistake.  There are some SDRC_POWER settings you have to have at run time.

The init code shouldn't through out ACTIMINGS for DDR unless there is some policy in place, but it has less authority around power mode settings.

Regards,
Richard W.
