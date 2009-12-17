From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: I2C: Add mpu wake up latency constraint in i2c
Date: Thu, 17 Dec 2009 12:25:10 -0800
Message-ID: <20091217202509.GZ4575@atomide.com>
References: <1259172229-25386-1-git-send-email-kalle.jokiniemi@nokia.com>
 <E839BB5467CE1640B3CC2F90F647A52C274A0E73AB@NOK-EUMSG-02.mgdnok.nokia.com>
 <alpine.DEB.2.00.0911300023120.17083@utopia.booyaka.com>
 <E839BB5467CE1640B3CC2F90F647A52C274B07929A@NOK-EUMSG-02.mgdnok.nokia.com>
 <20091217173628.306a378b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61042 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759035AbZLQUZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 15:25:19 -0500
Content-Disposition: inline
In-Reply-To: <20091217173628.306a378b@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: kalle.jokiniemi@nokia.com, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jouni.hogander@nokia.com, khilman@deeprootsystems.com, kalle.jokiniemi@digia.com, m-sonasath@ti.com, jhnikula@gmail.com, nm@ti.com, paul@pwsan.com, ben-linux@fluff.org

* Jean Delvare <khali@linux-fr.org> [091217 08:35]:
> On Thu, 17 Dec 2009 16:18:24 +0100, kalle.jokiniemi@nokia.com wrote:
> > Hi Jean,
> > 
> > > -----Original Message-----
> > > From: Jokiniemi Kalle (Nokia-D/Tampere) 
> > > Sent: 11. joulukuuta 2009 12:47
> > > To: 'ext Paul Walmsley'; ben-linux@fluff.org
> > > Cc: linux-i2c@vger.kernel.org; linux-omap@vger.kernel.org; 
> > > Ujfalusi Peter (Nokia-D/Tampere); Hogander Jouni 
> > > (Nokia-D/Tampere); khilman@deeprootsystems.com; 
> > > kalle.jokiniemi@digia.com; m-sonasath@ti.com; 
> > > jhnikula@gmail.com; nm@ti.com
> > > Subject: RE: [PATCH] OMAP: I2C: Add mpu wake up latency 
> > > constraint in i2c
> > > 
> > > Hi Ben,
> > > 
> > > What's the status on this one? Have you had time to check it out?
> > > 
> > > - Kalle
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: ext Paul Walmsley [mailto:paul@pwsan.com]
> > > > Sent: 30. marraskuuta 2009 9:24
> > > > To: Jokiniemi Kalle (Nokia-D/Tampere)
> > > > Cc: ben-linux@fluff.org; linux-i2c@vger.kernel.org; 
> > > > linux-omap@vger.kernel.org; Ujfalusi Peter 
> > > (Nokia-D/Tampere); Hogander 
> > > > Jouni (Nokia-D/Tampere); khilman@deeprootsystems.com; 
> > > > kalle.jokiniemi@digia.com; m-sonasath@ti.com; jhnikula@gmail.com; 
> > > > nm@ti.com
> > > > Subject: RE: [PATCH] OMAP: I2C: Add mpu wake up latency 
> > > constraint in 
> > > > i2c
> > > > 
> > > > Hi Ben, Kalle,
> > > > 
> > > > On Thu, 26 Nov 2009, kalle.jokiniemi@nokia.com wrote:
> > > > 
> > > > > Could you take this patch to i2c tree? The patch has been
> > > > discussed in linux-omap list, and this version was the one that was 
> > > > agreed to pushed forward.
> > 
> > 
> > Ben is bit unresponsive about my patch. Would you Jean be the current linux-i2c maintainer?
> 
> Only for the core and PC drivers. Not platform drivers.
> 
> > Could you take my patch in?
> 
> Not really. Either wait for Ben to respond, or push the patch through
> the OMAP tree. If this really doesn't work, you might try Andrew Morton.

Ack from me too for Ben.

Acked-by: Tony Lindgren <tony@atomide.com>
