From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Git tree updated, clocks and PM code reset to mainline
Date: Mon, 6 Apr 2009 09:29:14 +0300
Message-ID: <20090406092914.5af65751.jarkko.nikula@nokia.com>
References: <20090403001333.GR32530@atomide.com>
	<20090403091553.82ceacf8.jarkko.nikula@nokia.com>
	<87k561htu0.fsf@litku.valot.fi>
	<alpine.DEB.2.00.0904041630170.8305@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57961 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbZDFG2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 02:28:54 -0400
In-Reply-To: <alpine.DEB.2.00.0904041630170.8305@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, 5 Apr 2009 00:33:25 +0200
ext Paul Walmsley <paul@pwsan.com> wrote:

> Evidently the 24xx clock code/data was never actually tested.  Does
> this patch work for you?
> 
Thanks Paul! Your patch makes N810 booting up to retu initialization
(kernel BUG at drivers/cbus/retu.c:90!) but I don't think so this has
anything to do with the clock changes.

I noticed also that N810 hangs like Beagle in delay loop calibration
when compiled with 2007q3-53. For <= ARM11 I still use good old
2005q3 :-)


Jarkko
