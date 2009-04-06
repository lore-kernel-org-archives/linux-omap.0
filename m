From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Git tree updated, clocks and PM code reset to mainline
Date: Mon, 6 Apr 2009 04:49:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904060446130.22223@utopia.booyaka.com>
References: <20090403001333.GR32530@atomide.com> <20090403091553.82ceacf8.jarkko.nikula@nokia.com> <87k561htu0.fsf@litku.valot.fi> <alpine.DEB.2.00.0904041630170.8305@utopia.booyaka.com> <20090406092914.5af65751.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53021 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbZDFKtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 06:49:40 -0400
In-Reply-To: <20090406092914.5af65751.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 6 Apr 2009, Jarkko Nikula wrote:

> On Sun, 5 Apr 2009 00:33:25 +0200
> ext Paul Walmsley <paul@pwsan.com> wrote:
> 
> > Evidently the 24xx clock code/data was never actually tested.  Does
> > this patch work for you?
> > 
> Thanks Paul! Your patch makes N810 booting up to retu initialization
> (kernel BUG at drivers/cbus/retu.c:90!) but I don't think so this has
> anything to do with the clock changes.

Cool, thanks for testing, Jarkko.  Will queue cleaned-up versions of these 
fixes into the omap-clock-test branch.  I test-booted them on the N800 
here and didn't see the retu bug, but maybe N800 interacts with it 
differently?

> I noticed also that N810 hangs like Beagle in delay loop calibration
> when compiled with 2007q3-53. For <= ARM11 I still use good old
> 2005q3 :-)

Hehe.


- Paul
